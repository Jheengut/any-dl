(*
  any-dl:
  -------
  Generic Media-Downloader for any kind of Online-Mediathek.

  Author / copyright: Oliver Bandel
  Copyleft:           GNU GENERAL PUBLIC LICENSE  v3 (or higher)
*)


type col_t          = string array     (* Hselect as well as VSelec are represented the same way - late think of it as a row *)
type row_t          = string array     (* Hselect as well as VSelec are represented the same way - late think of it as a row *)
type match_result_t = string array array
type selector_t     = ( match_result_t -> match_result_t ) (* function, that has a certain algorithm to select certain match_result_t *)


type results_t =
  | String        of string                       (* general purpose string *)
  | String_array  of string array
  | Document      of  string * string             (* (document, url-of-doc) *)
  | Url           of  string * string             (* (url, referrer) needed for Get-command *)
  | Url_list      of (string * string) list
  | Url_array     of (string * string) array
  | Dummy_result
  | Match_result  of match_result_t
  | Empty


type commands_t =
  | Get_url       of string * string          (* url, referrer *)
  | Get_urls                                  (* get via tmpvar *)                   (* can be removed maybe *)
  | Get                                       (* get ONE document via tmpvar (Url-type) *)
  | Match             of string               (* regexp-pattern-string *)
  | Select            of int list             (* index-list for item-selection *) (* im Moment wie ColSelect *)
  | Link_extract                              (* extracts html-href's from webpage *)
  | Link_extract_xml                          (* extracts html-href's from (xml-formatted) webpage (e.g. asx-files) *)
  | Paste                                     (* paste together strings *)
  | Store             of string               (* Store the tmpvar (1-val-stack) to a named variable *)
  | Recall            of string               (* Recall a named variable and store it back to the tmpvar (1-val-stack) *)
  | Show_variables                            (* print all named variables *)
  (*
  | Select            of selector_t           (* acts as a filter *)
  *)
  | Print
  | Show_match
  | Print_string of string
  | Save         of string * string
  | Setvar       of results_t
  | Show_type
  | ColSelect  of int  (* horizontal selection of a matrix (match-result) *)
  | RowSelect  of int  (* vertical   selection of a matrix (match-result) *)
  | Exit_parse
  | Dummy



let result_to_string res = match res with
    | String         _ -> "String"
    | String_array   _ -> "String_array"
    | Document       _ -> "Document"
    | Url            _ -> "Url"
    | Url_list       _ -> "Url_list"
    | Url_array      _ -> "Url_array"
    | Dummy_result     -> "Dummy_result"
    | Match_result   _ -> "Match_result"
    | Empty            -> "Empty"



let command_to_string cmd = match cmd with
  | Get_url        _ -> "Get_url"
  | Get_urls       _ -> "Get_urls" (* can be removed maybe *)
  | Get            _ -> "Get"
  | Match          _ -> "Match"
  | Select         _ -> "Select"
  | Link_extract     -> "Link_extract"
  | Link_extract_xml -> "Link_extract_xml"
  | Paste            -> "Paste"
  | Store          _ -> "Store"
  | Recall         _ -> "Recall"
  | Show_variables _ -> "Show_variables"
  | Print            -> "Print"
  | Show_match       -> "Show_match"
  | Print_string   _ -> "Print_string"
  | Save           _ -> "Save"
  | Setvar         _ -> "Setvar"
  | Show_type      _ -> "Show_type"
  | ColSelect      _ -> "ColSelect" 
  | RowSelect      _ -> "RowSelect"
  | Exit_parse     _ -> "Exit_parse"
  | Dummy            -> "Dummy"
  




(* Parser( <parser-name>, <url-match-list>, commands-list> *)
(* ------------------------------------------------------- *)
type parserdef_t = { parsername : string; urllist:  string list; commands:  commands_t list }


