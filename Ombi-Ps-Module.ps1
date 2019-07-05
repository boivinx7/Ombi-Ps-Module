cls

#####################
#                HOW TO USE
#          
#        TO MANAGE THE ---- Jay and Silent Bob Strike Back ---- MOVIE
#                         OmbiMovieRequest -TMDBID 2294
#                         OmbiMovieDelete -TMDBID 2294
#                         OmbiMovieSearch -TMDBID 2294
#          
#####################

############SET VARIABLES###########
$OmbiURL = ""     #########YOUR OMBI IPADDRESS AND PORT
$OmbiToken = ""#########YOUR OMBI API KEY

###########REQUEST A MOVIE IN OMBI#########
function OmbiMovieRequest {
Param($TMDBID)
$OmbiRequest = $OmbiURL + "/api/v1/Request/movie/"
$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$header.add("apikey", $OmbiToken)
$body = (@{
            theMovieDbId = $TMDBID
            #languageCode = $LangCode
          }) | convertto-json

$Invoke = Invoke-WebRequest -Uri $OmbiRequest -Headers $header -Body $body -Method Post -ContentType application/json
$content = $Invoke.content | ConvertFrom-Json
#$content
}

####SEARCH FUNCTION
function OmbiMovieSearch {
Param($TMDBID)
$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$header.add("apikey", $OmbiToken)
$OmbiSearch = $OmbiURL + "/api/v1/Search/movie/info/" + $TMDBID
$Invoke = Invoke-WebRequest -Uri $OmbiSearch -Headers $header -Method GET -ContentType application/json
$content = $Invoke.content | ConvertFrom-Json
$content.requestId
}

##### DELETE FUNCTION
function OmbiMovieDelete {
Param($TMDBID)
$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$header.add("apikey", $OmbiToken)
#####SEARCH THE REQUESTED MOVIE REQUEST ID
$OmbiSearch = $OmbiURL + "/api/v1/Search/movie/info/" + $TMDBID
$Invoke = Invoke-WebRequest -Uri $OmbiSearch -Headers $header -Method GET -ContentType application/json
$content = $Invoke.content | ConvertFrom-Json

#DELETE THE REQUESTED MOVIE
$OmbiDelete = $OmbiURL + "/api/v1/Request/movie/" + $content.requestId
$Invoke = Invoke-WebRequest -Uri $OmbiDelete -Headers $header -Method DELETE -ContentType application/json
#$content = $Invoke.content | ConvertFrom-Json
#$content
}
