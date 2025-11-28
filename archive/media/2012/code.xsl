<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:umb="urn:umbraco.library"  xmlns:crop="urn:Eksponent.CropUp" xmlns:umedia="urn:ucomponents.media"
	exclude-result-prefixes="msxml umb crop umedia">

	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:param name="currentPage"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

	
	<xsl:template match="/">
		<!-- Here we apply a template to the currentPage parameter, which has any descendant Product nodes that are not hidden -->
		<!-- The currentPage parameter contains a Category root node -->
		<xsl:apply-templates select="$currentPage[descendant::Product[not(umbracoNaviHide= 1)]]" />
	</xsl:template>
	
	<xsl:template match="Category">
		<ul>
			<!-- Here we apply a template to the Product nodes that are not hidden -->
			<xsl:apply-templates select="descendant::Product[not(umbracoNaviHide= 1)]" />
		</ul>
	</xsl:template>
	
	<xsl:template match="Product">
		<!-- Lets check if productNumber contains any data, otherwise we give at a default value.  Remember to have an image called 'default' -->
		<xsl:variable name="mediaUrlName">
			<xsl:choose>
				<xsl:when test="productNumber[normalize-space()]">
					<xsl:value-of select="productNumber" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'default'" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Here we use the GetMediaByUrlName from uComponents to get the Image selected in the productNumber property.	And in case it returns multiple items, we just select the first [1]-->
		<xsl:variable name="media" select="umedia:GetMediaByUrlName(translate($mediaUrlName, $uppercase, $lowercase))[1]" />
		
		<li>			
			<xsl:apply-templates select="productTitle[normalize-space()]" />
			
			<!-- If the media variable has any content, we apply a template to it, and we pass a crop mode to the CropUp extension -->	
			<xsl:apply-templates select="$media[normalize-space()]" mode="media">
				<xsl:with-param name="crop" select="'150x170M'" />
			</xsl:apply-templates>
	  </li>
	</xsl:template>
	
	<xsl:template match="productTitle">
		<h2>
			<a href="{umb:NiceUrl(../@id)}">
				<xsl:value-of select="." />
			</a>
		</h2>
	</xsl:template>
	
	<!-- This template 'catches' the apply in line 36 -->
	<xsl:template match="Image" mode="media">
		<xsl:param name="crop" />
		<div class="image">
      <a href="{umb:NiceUrl(ancestor::*[@isDoc]/@id)}">
				<img src="{crop:Url(umbracoFile, $crop)}" />
			</a>
		</div>
	</xsl:template>
	
	<!-- This template 'catches' the apply in line 36, if it contains an error node -->
	<!-- Thing goes apeshit if an Image is selected and then later on deleted from the media section -->
	<xsl:template match="Image[error]|*" mode="media" />
</xsl:stylesheet>