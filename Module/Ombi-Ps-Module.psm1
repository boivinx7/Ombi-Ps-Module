<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.163
	 Created on:   	2019-06-03 8:28 PM
	 Created by:   	Administrator
	 Organization: 	
	 Filename:     	Ombi-Ps-Module.psm1
	-------------------------------------------------------------------------
	 Module Name: Ombi-Ps-Module
	===========================================================================
#>



<#
	.SYNOPSIS
		To Find Ombi TV Requests
	
	.DESCRIPTION
		A detailed description of the Get-OmbiTVRequest function.
	
	.PARAMETER OmbiURL
		Ombi URL Exemple https:\\Server.ombi.com:5100
	
	.PARAMETER Token
		The Ombi API Key
	
	.EXAMPLE
		PS C:\> Get-OmbiTVRequest -OmbiURL 'Value1' -Token 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-OmbiTVRequest
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$OmbiURL,
		[Parameter(Mandatory = $true)]
		[string]$Token
	)
	
	$URI = $OmbiURL + "/api/v1/Request/Tv"
	$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$header.Add("apiKey", $token)
	
	$Invoke = Invoke-WebRequest -Uri $uri -Headers $header
	
	$Content = $Invoke.content | ConvertFrom-Json
	$Content
}

<#
	.SYNOPSIS
		Get all ombi movie request
	
	.DESCRIPTION
		A detailed description of the Get-OmbiMoviesRequest function.
	
	.PARAMETER OmbiURL
		A description of the OmbiURL parameter.
	
	.PARAMETER Token
		A description of the Token parameter.
	
	.EXAMPLE
				PS C:\> Get-OmbiMoviesRequest -OmbiURL 'Value1' -Token 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-OmbiMoviesRequest
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$OmbiURL,
		[Parameter(Mandatory = $true)]
		[string]$Token
	)
	
	$URI = $OmbiURL + "/api/v1/Request/Movie"
	$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$header.Add("apiKey", $token)
	
	$Invoke = Invoke-WebRequest -Uri $uri -Headers $header
	
	$Content = $Invoke.content | ConvertFrom-Json
	$Content
}

<#
	.SYNOPSIS
		To Request Movie in Ombi
	
	.DESCRIPTION
		A detailed description of the Request-OmbiMovie function.
	
	.PARAMETER OmbiURL
		A description of the OmbiURL parameter.
	
	.PARAMETER Token
		A description of the Token parameter.
	
	.PARAMETER TMDBID
		A description of the TMDBID parameter.
	
	.PARAMETER LANGCODE
		A description of the LANGCODE parameter.
	
	.EXAMPLE
		PS C:\> Request-OmbiMovie -LANGCODE 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Set-OmbiMovieRequest
{
	[CmdletBinding(DefaultParameterSetName = 'EN')]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$OmbiURL,
		[Parameter(Mandatory = $true)]
		[string]$Token,
		[Parameter(Mandatory = $true)]
		[string]$TMDBID,
		[Parameter(Mandatory = $true)]
		[ValidateSet('EN', 'FR', 'ES')]
		[string]$LANGCODE
	)
	
	$URI = $OmbiURL + "/api/v1/Request/Movie"
	$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$header.Add("apiKey", $token)
	$body = (@{
			theMovieDbId = $TMDBID
			languageCode = $LANGCODE
		}) | ConvertTo-Json
	$Invoke = Invoke-WebRequest -Uri $uri -Headers $header -Body $body -Method POST -ContentType "application/json"
	$Invoke.content | ConvertFrom-Json
}


function Set-OmbiTVRequest
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$OmbiURL,
		[Parameter(Mandatory = $true)]
		[string]$Token,
		[Parameter(Mandatory = $true)]
		[string]$tvDbId,
		[Parameter(Mandatory = $true)]
		[bool]$requestAll,
		[Parameter(Mandatory = $true)]
		[bool]$latestSeason,
		[Parameter(Mandatory = $true)]
		[bool]$firstSeason
	)
	
	$URI = $OmbiURL + "/api/v1/Request/tv"
	$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$header.Add("apiKey", $token)
	$body = (@{
			requestAll = $requestAll
			latestSeason = $latestSeason
			firstSeason   = $firstSeason
			tvDbId = $tvDbId
		}) | ConvertTo-Json
	$Invoke = Invoke-WebRequest -Uri $uri -Headers $header -Body $body -Method POST -ContentType "application/json"
	$Invoke.content | ConvertFrom-Json
}

<#
	.SYNOPSIS
		Search Ombi movie request with tmdb id
	
	.DESCRIPTION
		A detailed description of the Search-OmbiMovie function.
	
	.PARAMETER TMDBID
		A description of the TMDBID parameter.
	
	.PARAMETER Token
		A description of the Token parameter.
	
	.PARAMETER OmbiURL
		A description of the OmbiURL parameter.
	
	.EXAMPLE
				PS C:\> Search-OmbiMovie -TMDBID 'Value1' -Token 'Value2' -OmbiURL 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Find-OmbiMovie
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$TMDBID,
		[Parameter(Mandatory = $true)]
		[string]$Token,
		[Parameter(Mandatory = $true)]
		[string]$OmbiURL
	)
	
	$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$header.add("apikey", $token)
	$OmbiSearch = $OmbiURL + "/api/v1/Search/movie/info/$TMDBID"
	$Invoke = Invoke-WebRequest -Uri $OmbiSearch -Headers $header -Method GET -ContentType application/json
	$content = $Invoke.content | ConvertFrom-Json
	$content
}


<#
	.SYNOPSIS
		To Delete movie Request
	
	.DESCRIPTION
		A detailed description of the Delete-OmbiMovie function.
	
	.PARAMETER Request ID
		A description of the TMDBID parameter.
	
	.PARAMETER Token
		A description of the Token parameter.
	
	.PARAMETER OmbiURL
		A description of the OmbiURL parameter.
	
	.EXAMPLE
		PS C:\> Delete-OmbiMovie -TMDBID 'Value1' -Token 'Value2' -OmbiURL 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Delete-OmbiMovie
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$RequestID,
		[Parameter(Mandatory = $true)]
		[string]$Token,
		[Parameter(Mandatory = $true)]
		[string]$OmbiURL
	)
	
	$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$header.add("apikey", $token)
	$OmbiDelete = $OmbiURL + "/api/v1/Request/movie/$RequestID"
	$Invoke = Invoke-WebRequest -Uri $OmbiDelete -Headers $header -Method DELETE -ContentType application/json
}