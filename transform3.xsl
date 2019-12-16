<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">   
<xsl:output method="html" indent="yes" doctype-public="-//IETF//DTD HTML//EN" encoding="utf-8"/>

<xsl:template match="*">	
<HTML>
	<HEAD>
		<xsl:call-template name="title" /> 
	</HEAD>
	<BODY>
		<TABLE width="600" border="1">
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
		<xsl:when test="header | nav | article | aside | footer | section | div">		  
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
			<xsl:call-template name="explorer" />						 
        </xsl:otherwise>
     </xsl:choose>		
</xsl:template>

<xsl:template name="explorer">
	<xsl:if test="not(./*)">
		<xsl:value-of select="."/>
	</xsl:if>
	<xsl:for-each select="./*">
		<xsl:call-template name="content" />
	</xsl:for-each>
</xsl:template>

<xsl:template name="ul">
    <xsl:element name="{name()}">
		<xsl:for-each select="li">  
			<LI>
				<xsl:call-template name="childs" />
			</LI>
		</xsl:for-each>
    </xsl:element>
</xsl:template>

<xsl:template name="a">
	<xsl:if test="@href">
    <A>		
		<xsl:attribute name="HREF">
			<xsl:value-of select="@href" />
		</xsl:attribute>	
		<xsl:call-template name="childs" />
		<xsl:if test="not(. = text())">
			<xsl:value-of select="@href" />
		</xsl:if>
	</A>
	</xsl:if>
</xsl:template>

<xsl:template name="img">
	<xsl:if test="@src">
    <IMG>		
		<xsl:attribute name="SRC">
			<xsl:value-of select="@src" />
		</xsl:attribute>
		<xsl:attribute name="TITLE">
			<xsl:value-of select="@alt" />
		</xsl:attribute>
		<xsl:attribute name="ALIGN">
			<xsl:text>BOTTOM</xsl:text>
		</xsl:attribute>	
	</IMG>
	</xsl:if>
</xsl:template>

<xsl:template name="h1">
	<xsl:element name="{name()}">
		<xsl:call-template name="childs" />
	</xsl:element>	
</xsl:template>

<xsl:template name="table">
	<TABLE>
		<xsl:for-each select="tr">
			<TR>
				<xsl:for-each select="td">
					<TD><xsl:call-template name="childs" /></TD>
				</xsl:for-each>
			</TR>
		</xsl:for-each>			
	</TABLE>
</xsl:template>

<xsl:template name="childs">
	<xsl:choose>		
		<xsl:when test="./* and not(text())">
			<xsl:call-template name="explorer"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="." />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="content">
	<xsl:choose>		
		<xsl:when test="self::a">
			<xsl:call-template name="a" />
		</xsl:when> 
		<xsl:when test="self::ul | self::ol | self::menu">
			<xsl:call-template name="ul" />
		</xsl:when> 
		<xsl:when test="self::table">
			<xsl:call-template name="table" />			
		</xsl:when> 
		<xsl:when test="self::h1 | self::h2 | self::h3 | self::h4 | self::h5 | self::h6">
			<xsl:call-template name="h1" />
		</xsl:when> 
		<xsl:when test="self::img">
			<xsl:call-template name="img" />
		</xsl:when>
		<xsl:when test="self::p">
			<P>
				<xsl:call-template name="childs" />
			</P>					
		</xsl:when>
		<xsl:when test="self::address">
			<ADDRESS><xsl:call-template name="childs" /></ADDRESS>					
		</xsl:when>
		<xsl:when test="self::pre">
			<PRE><xsl:value-of select="." /></PRE>					
		</xsl:when>
		<xsl:when test="self::time">
			<EM><xsl:value-of select="." /></EM>					
		</xsl:when>
		<xsl:when test="self::br">
			<xsl:value-of select="." /><BR/>					
		</xsl:when>
		<xsl:when test="self::b | self:: strong">
			<STRONG><xsl:value-of select="." /></STRONG>					
		</xsl:when>
		<xsl:when test="self::em | self::i">
			<EM><xsl:value-of select="." /></EM>					
		</xsl:when>
		<xsl:when test="self::cite">
			<CITE><xsl:value-of select="." /></CITE>					
		</xsl:when>
		<xsl:when test="self::code">
			<CODE><xsl:value-of select="." /></CODE>					
		</xsl:when>
		<xsl:when test="self::blockquote">
			<BLOCKQUOTE><xsl:value-of select="." /></BLOCKQUOTE>					
		</xsl:when> 	 	            			
		<xsl:when test="self::u">
			<U><xsl:value-of select="." /></U>					
		</xsl:when>	
		<xsl:when test="self::tt">
			<TT><xsl:value-of select="." /></TT>					
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="." />
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>


</xsl:stylesheet>
