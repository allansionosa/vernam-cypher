-module(vernam26).
-export([encrypt/2, decrypt/2]).

encrypt(Plain_text, Key_text) ->
  Key_repeating = repeat_key(Key_text, length(Plain_text)),
  encrypt(Plain_text, Key_repeating, []).

encrypt([], [], Cipher_text_accumulated) -> lists:reverse(Cipher_text_accumulated);
    
encrypt(Plain_text, Key_text, Cipher_text_accumulated) ->
  [Plain_text_head|Plain_text_tail] = Plain_text,
  [Key_text_head|Key_text_tail] = Key_text,
  Plain_and_key_text_head = (Plain_text_head - 97) + (Key_text_head - 97),
  Plain_and_key_text_head_correspond = to_letter(Plain_and_key_text_head),
  Ciphered_result = [ Plain_and_key_text_head_correspond | Cipher_text_accumulated],
  encrypt(Plain_text_tail, Key_text_tail, Ciphered_result).

decrypt(Cipher_text, Key_text) ->
  Key_repeating = repeat_key(Key_text, length(Cipher_text)),
  decrypt(Cipher_text, Key_repeating, []).

decrypt([], [], Plain_text_accumulated) -> lists:reverse(Plain_text_accumulated);

decrypt(Cipher_text, Key_text, Plain_text_accumulated) ->
  [Cipher_text_head|Cipher_text_tail] = Cipher_text,
  [Key_text_head|Key_text_tail] = Key_text,
  Cipher_and_key_text_head = (Cipher_text_head - 97) - (Key_text_head - 97),
   Plain_and_key_text_head_correspond = to_letter(Cipher_and_key_text_head),
  Plain_text_result = [ Plain_and_key_text_head_correspond | Plain_text_accumulated],
  decrypt(Cipher_text_tail, Key_text_tail, Plain_text_result).

to_letter(Plain_text_or_cipher_text_accumulated) when Plain_text_or_cipher_text_accumulated >= 0, Plain_text_or_cipher_text_accumulated =< 25 ->
  Cipher = lists:nth(Plain_text_or_cipher_text_accumulated + 1, "abcdefghijklmnopqrstuvwxyz"),
  Cipher;

to_letter(Plain_text_or_cipher_text_accumulated) when Plain_text_or_cipher_text_accumulated < 0 ->
  Cipher = lists:nth(Plain_text_or_cipher_text_accumulated + 27, "abcdefghijklmnopqrstuvwxyz"),
  Cipher;

to_letter(Plain_text_or_cipher_text_accumulated) when Plain_text_or_cipher_text_accumulated > 25 ->
  Cipher = lists:nth(Plain_text_or_cipher_text_accumulated - 25, "abcdefghijklmnopqrstuvwxyz"),
  Cipher.

repeat_key(Key_text, Length_calculation) ->
  Length_determination = length(Key_text),
  Key_repeating = lists:flatten(lists:sublist(lists:duplicate(Length_calculation div Length_determination + 1, Key_text), Length_calculation)),
  lists:sublist(Key_repeating, Length_calculation).