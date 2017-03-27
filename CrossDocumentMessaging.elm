module CrossDocumentMessaging exposing (Site, postString, openSite, close)

import Result
import Maybe exposing (..)
import Native.CrossDocumentMessaging

type Site = Site
postString: Site -> String -> String -> Maybe String -> Result String String

postString site message origin transfers =
    case transfers of
        Nothing ->
            Ok (Native.CrossDocumentMessaging.postMessage site message origin)
        Just transfers ->
            Ok (Native.CrossDocumentMessaging.postMessageWithTransfers site message origin transfers)



openSite: String -> Maybe String -> Maybe String -> Site
openSite url name specs =
    openNativeSite url (name |> withDefault "") (specs |> withDefault "")

openNativeSite: String -> String -> String -> Site
openNativeSite =
    Native.CrossDocumentMessaging.open

getOrigin: () -> Maybe Site
getOrigin =
    Native.CrossDocumentMessaging.origin

close: Maybe Site -> ()
close site =
    case site of
        Nothing ->
            Native.CrossDocumentMessaging.close
        Just site ->
            Native.CrossDocumentMessaging.close site