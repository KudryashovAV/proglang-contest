package phones

import scala.io.Source

class Phones(words: Seq[String]) {
  val numberToWords = words.groupBy(Phones.wordToNumber)

  def encodings(number: String): Seq[String] = {
    def iter(digits: String): Seq[List[String]] = {
      if (digits.length == 0) Seq(List())
      else for {
        i <- 1 to digits.length
        (head, tail) = digits.splitAt(i)
        if numberToWords.contains(head)
        tailEnc <- iter(tail)
        headEnc <- numberToWords(head)
      } yield headEnc :: tailEnc
    }

    iter(number).map(_.mkString(" "))
  }
}

object Phones {
  val wordsFile = "../dictionary.txt"

  val digitToLetters = Map(
    '2' -> "ABC", '3' -> "DEF", '4' -> "GHI", '5' -> "JKL",
    '6' -> "MNO", '7' -> "PQRS", '8' -> "TUV", '9' -> "WXYZ")

  val letterToDigit: Map[Char, Char] =
    (for ((d, letters) <- digitToLetters; l <- letters) yield l -> d).toMap

  def wordToNumber(word: String): String = {
    word.toUpperCase.map(letterToDigit.withDefaultValue("")).mkString
  }

  def apply(words: String*) = new Phones(words)
  def apply() = new Phones(Source.fromFile(wordsFile, "UTF-8").getLines.toSeq)
}
