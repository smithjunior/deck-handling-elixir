defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  Provide methos for creating and handling a deck of cards
  """

  @doc """
  Return a list of strings representng a deck of playing cards
  """
  def create_deck do
    values = ["Ace","Two", "Three", "Four", "Five", "Six", "Seven", "Eigth", "Nine"]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]

    cards = for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end

    List.flatten(cards)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc  """

    Determines a whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamond",
       "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamond",
       "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamond",
       "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamond",
       "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamond",
       "Six of Spades", "Six of Clubs", "Six of Hearts", "Six of Diamond",
       "Seven of Spades", "Seven of Clubs", "Seven of Hearts", "Seven of Diamond",
       "Eigth of Spades", "Eigth of Clubs", "Eigth of Hearts", "Eigth of Diamond",
       "Nine of Spades", "Nine of Clubs", "Nine of Hearts", "Nine of Diamond"]
      iex> Cards.contains?(deck, "Ace of Spades")
      true


  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """

    Divides a deck into a hand and the remainder of the deck
    the `hand_size` argument indicates how many cards should
    be in the hand

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term binary
      { :error, _reason } ->  "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end

