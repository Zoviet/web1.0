<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">   
<xsl:output method="html" indent="yes" doctype-public="-//IETF//DTD HTML//EN" encoding="utf-8"/>

<xsl:template match="*">	
<HTML>
	<HEAD>
		<xsl:call-template name="title" /> 
	</HEAD>
	<BODY>	
		<TABLE>
			<xsl:apply-templates select="body" />
		</TABLE>
	</BODY>
</HTML>	
</xsl:template>

<xsl:template name="title">
    <TITLE><xsl:value-of select="//head/title"/></TITLE>
</xsl:template>

<xsl:template match="body">
	<xsl:for-each select="child::*"> 
		<xsl:apply-templates select="header | nav | article | aside | footer | section | div" /> 		
	</xsl:for-each>	 
</xsl:template>

<xsl:template match="header | nav | article | aside | footer | section | div">
	 <xsl:choose>
		<xsl:when test="div">		  
			<xsl:choose>
				<xsl:when test="count(ancestor::header | nav | article | aside | footer | section | div)=1">         
					<TR>
						<xsl:apply-templates select="header | nav | article | aside | footer | section | div" />		
					</TR>
				</xsl:when>
				<xsl:when test="count(ancestor::header | nav | article | aside | footer | section | div) &gt; 1">         
					<TD>
						<xsl:apply-templates select="header | nav | article | aside | footer | section | div" />		
					</TD>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="header | nav | article | aside | footer | section | div" />
				</xsl:otherwise>
			</xsl:choose>	
        </xsl:when>	
        <xsl:otherwise>						
			<xsl:call-template name="content" /> 
        </xsl:otherwise>
     </xsl:choose>		
</xsl:template>

<xsl:template match="ul | ol | menu">
    <UL>
		<xsl:for-each select="li">  
			<LI>
				 <xsl:choose>
					<xsl:when test="a">
						<xsl:apply-templates select="a" />
					</xsl:when>              
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</LI>
		</xsl:for-each>
    </UL>
</xsl:template>

<xsl:template match="a">
	<xsl:if test="@href">
    <A>		
		<xsl:attribute name="href">
			<xsl:value-of select="@href" />
		</xsl:attribute>	
		<xsl:value-of select="." />
		<xsl:if test="not(. = text())">
			<xsl:value-of select="@href" />
		</xsl:if>
	</A>
	</xsl:if>
</xsl:template>

<xsl:template match="h1 | h2 | h3 | h4 | h5 | h6">
	<xsl:element name="{name()}">
		<xsl:value-of select="."/>
	</xsl:element>	
</xsl:template>


<xsl:template match="table">
	<TABLE>
		<xsl:for-each select="tr">
			<TR>
				<xsl:for-each select="td">
					<TD><xsl:value-of select="." /></TD>
				</xsl:for-each>
			</TR>
		</xsl:for-each>			
	</TABLE>
</xsl:template>

<xsl:template name="content">
	<xsl:for-each select=".//*">
		<xsl:if test="descendant::*">
			<xsl:call-template name="content" /> 
		</xsl:if>
	<xsl:choose>		
		<xsl:when test="a">
			<xsl:apply-templates select="a" />
		</xsl:when> 
		<xsl:when test="ul | ol | menu">
			<xsl:apply-templates select="ul | ol | menu" />
		</xsl:when> 
		<xsl:when test="table">
			<xsl:apply-templates select="table" />			
		</xsl:when> 
		<xsl:when test="h1 | h2 | h3 | h4 | h5 | h6">
			<xsl:apply-templates select="h1 | h2 | h3 | h4 | h5 | h6" />						
		</xsl:when> 
		<xsl:when test="p">
			<P><xsl:value-of select="." /></P>					
		</xsl:when> 	            				
		<xsl:otherwise>
			<xsl:value-of select="." />
		</xsl:otherwise>
	</xsl:choose>
	</xsl:for-each>	
</xsl:template>


</xsl:stylesheet>
