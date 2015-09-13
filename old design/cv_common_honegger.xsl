<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv.xml?>
<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpa-functions" xmlns:cv="http://cv" xmlns="http://www.w3.org/1999/XSL/Format">
	<!-- do a parent for inherit default font Attrs -->
	<xsl:template name="main">
		<xsl:element name="{$block}" use-attribute-sets="defaultFontAttrs">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!-- person -->
	<xsl:template match="person">
		<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
			<xsl:element name="{$table}" use-attribute-sets="borderedTableAttrs">
				<xsl:call-template name="rigthFixedColumnDefs"/>
				<xsl:element name="{$tableBody}">
					<xsl:element name="{$tableRow}">
						<xsl:element name="{$tableCell}" use-attribute-sets="verticalCenteredCellAttrs">
							<xsl:element name="{$block}">
								<xsl:call-template name="personText"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="{$tableCell}" use-attribute-sets="verticalCenteredCellAttrs">
							<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
								<xsl:call-template name="personImg"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- text part of the person (left side) -->
	<xsl:template name="personText">
		<xsl:element name="{$block}" use-attribute-sets="centeredParagrapthAttrs">
			<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
				<xsl:element name="{$block}" use-attribute-sets="highlightedAttrs">
					<xsl:apply-templates select="forename"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="name"/>
				</xsl:element>
				<xsl:element name="{$block}">
					<xsl:apply-templates select="title"/>
					<xsl:text> - </xsl:text>
					<xsl:apply-templates select="experience"/>
					<xsl:text> Jahre Berufserfahrung</xsl:text>
				</xsl:element>
			</xsl:element>
			<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
				<xsl:apply-templates select="contact"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- image of the person (rigth side) -->
	<xsl:template name="personImg">
		<xsl:element name="{$block}" use-attribute-sets="centeredParagrapthAttrs">
			<xsl:call-template name="picture">
				<xsl:with-param name="uri" select="//person/picture"/>
				<xsl:with-param name="width" select="$personPictureWidth"/>
				<xsl:with-param name="heigth" select="$personPictureHeigth"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<!-- contact -->
	<xsl:template match="contact">
		<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
			<xsl:apply-templates select="address"/>
		</xsl:element>
		<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
			<xsl:for-each select="phone">
				<xsl:element name="{$block}">
					<xsl:apply-templates select="current()"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
		<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
			<xsl:apply-templates select="email"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="address">
		<xsl:element name="{$block}">
			<xsl:element name="{$block}">
				<xsl:apply-templates select="street"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="streetnumber"/>
			</xsl:element>
			<xsl:element name="{$block}">
				<xsl:apply-templates select="zip"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="location"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="zip">
		<xsl:if test="/cv/@international=true()">
			<xsl:apply-templates select="@countryIsoCode"/>
			<xsl:text>-</xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="phone">
		<xsl:choose>
			<xsl:when test="@type = 'homePhone'">
				<xsl:text>Privat: </xsl:text>
			</xsl:when>
			<xsl:when test="@type = 'cellPhone'">
				<xsl:text>Mobile: </xsl:text>
			</xsl:when>
			<xsl:when test="@type = 'businessPhone'">
				<xsl:text>Geschäft: </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text>0</xsl:text>
		<xsl:if test="/cv/@international=true()">
			<xsl:text>0</xsl:text>
			<xsl:apply-templates select="countryCode"/>
			<xsl:text>-(0)</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="areaCode"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="number"/>
	</xsl:template>
	<!-- skills -->
	<xsl:template match="skills">
		<xsl:apply-templates select="@title"/>
		<xsl:apply-templates select="skillgroup"/>
	</xsl:template>
    <xsl:template match="skillgroup">
		<xsl:call-template name="tableContent"/>
	</xsl:template>
	<xsl:template match="solidskill">
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:apply-templates select="../@title"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
                <xsl:text>Solide Kenntnisse in </xsl:text>
				<xsl:for-each select="skill">
				    <xsl:apply-templates select="current()"/>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
				<xsl:if test="@etc = true()">
					<xsl:text>, etc..</xsl:text>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
    <xsl:template match="goodskill">
        <xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
                <xsl:text></xsl:text>
            </xsl:element>
		</xsl:element>
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
                <xsl:text>Gute Kenntnisse in </xsl:text>
				<xsl:for-each select="skill">
    			    <xsl:apply-templates select="current()"/>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
				<xsl:if test="@etc = true()">
					<xsl:text>, etc..</xsl:text>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- educations -->
	<xsl:template match="educations">
		<xsl:apply-templates select="@title"/>
		<xsl:call-template name="tableContent"/>
	</xsl:template>
    <xsl:template match="training">
		<xsl:apply-templates select="@title"/>
		<xsl:call-template name="tableContent"/>
	</xsl:template>
	<xsl:template match="education">
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:call-template name="dateTemplate"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:apply-templates select="description"/>
				<xsl:for-each select="certificate">
					<xsl:element name="{$block}">
						<xsl:text>Zertifikat: </xsl:text>
						<xsl:apply-templates select="current()"/>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- certificats -->
	<xsl:template match="certificats">
		<xsl:apply-templates select="@title"/>
		<xsl:call-template name="tableContent"/>
	</xsl:template>
	<xsl:template match="certificat">
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:call-template name="dateTemplate"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:apply-templates select="description"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- expiriances -->
	<xsl:template match="experiences">
		<xsl:apply-templates select="@title"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="experiance">
		<xsl:element name="{$block}">
			<xsl:element name="{$block}" use-attribute-sets="h2Attrs">
				<xsl:apply-templates select="company"/>
			</xsl:element>
			<xsl:apply-templates select="period"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="period">
		<xsl:element name="{$block}">
			<xsl:element name="{$block}" use-attribute-sets="keepWithNextParagrapthAttrs">
				<xsl:element name="{$block}" use-attribute-sets="centeredParagrapthAttrs">
					<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
						<xsl:element name="{$block}" use-attribute-sets="highlightedAttrs">
							<xsl:call-template name="dateTemplate"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:apply-templates select="project"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="project">
		<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
			<xsl:element name="{$table}">
				<xsl:call-template name="tableColumnDefs"/>
				<xsl:element name="{$tableBody}">
					<xsl:element name="{$tableRow}" use-attribute-sets="evenRowAttrs">
						<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
							<xsl:element name="{$block}">
								<xsl:text>Projekt:</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
							<xsl:element name="{$block}">
								<xsl:apply-templates select="@title"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					<xsl:element name="{$tableRow}">
						<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
							<xsl:element name="{$block}">
								<xsl:text>Aktivitäten:</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
							<xsl:element name="{$block}">
								<xsl:element name="{$list}">
									<xsl:for-each select="activity">
										<xsl:apply-templates select="current()"/>
									</xsl:for-each>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="activity">
		<xsl:element name="{$listItem}">
			<xsl:element name="{$listItemLabel}">
				<xsl:element name="{$block}">
					<xsl:value-of select="$listLabelSign"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="{$listItemBody}" use-attribute-sets="listItemBodyAttrs">
				<xsl:element name="{$block}">
					<xsl:value-of select="current()"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- languages -->
	<xsl:template match="languages">
		<xsl:apply-templates select="@title"/>
		<xsl:call-template name="tableContent"/>
	</xsl:template>
	<xsl:template match="language">
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:apply-templates select="@name"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="{$tableCell}" use-attribute-sets="defaultCellAttrs">
			<xsl:element name="{$block}">
				<xsl:apply-templates select="skill"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="skill[text()='native']">
		<xsl:text>Muttersprache</xsl:text>
	</xsl:template>
    <xsl:template match="skill[text()='fluent']">
		<xsl:text>Schriftlich und mündlich fliessend</xsl:text>
	</xsl:template>
	<xsl:template match="skill[text()='good']">
		<xsl:text>Schriftlich und mündlich gut</xsl:text>
	</xsl:template>
	<!-- hobbies -->
	<xsl:template match="hobbys">
		<xsl:apply-templates select="@title"/>
		<xsl:element name="{$list}">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="hobby">
		<xsl:element name="{$listItem}">
			<xsl:element name="{$listItemLabel}">
				<xsl:element name="{$block}">
					<xsl:value-of select="$listLabelSign"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="{$listItemBody}" use-attribute-sets="listItemBodyAttrs">
				<xsl:element name="{$block}">
					<xsl:value-of select="current()"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- references -->
	<xsl:template match="references">
		<xsl:apply-templates select="@title"/>
        <xsl:if test="@ondemande = true()">
        	<xsl:text>Auf Anfrage</xsl:text>
	    </xsl:if>
		<xsl:for-each select="reference">
			<xsl:element name="{$block}" use-attribute-sets="defaultParagraphAttrs">
                <xsl:apply-templates select="current()"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
    
	<xsl:template match="reference">		
        <xsl:apply-templates select="name"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="forename"/>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="position"/>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="company"/>
		<xsl:text> </xsl:text>
	</xsl:template>
	<!-- formats titel at niveau 3 -->
	<xsl:template match="cv/*/@title">
		<xsl:element name="{$block}" use-attribute-sets="h1Attrs">
			<xsl:value-of select="current()"/>
		</xsl:element>
	</xsl:template>
	<!--A Table with a row for each content-->
	<xsl:template name="tableContent">
		<xsl:element name="{$block}">
			<xsl:element name="{$table}">
				<xsl:call-template name="tableColumnDefs"/>
				<xsl:element name="{$tableBody}">
					<xsl:for-each select="*">
						<xsl:if test="position() mod 2=0">
							<xsl:element name="{$tableRow}" use-attribute-sets="evenRowAttrs">
								<xsl:apply-templates select="current()"/>
							</xsl:element>
						</xsl:if>
						<xsl:if test="position() mod 2=1">
							<xsl:element name="{$tableRow}" use-attribute-sets="oddRowAttrs">
								<xsl:apply-templates select="current()"/>
							</xsl:element>
						</xsl:if>
					</xsl:for-each>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!--Dates formatting (exclusion and order garanteed by schema)-->
	<xsl:function name="cv:month-name-de" as="xs:string?">
  		<xsl:param name="month" as="xs:integer?"/>
		<xsl:sequence select="('Jan.', 'Feb.', 'März', 'Apr.', 'Mai', 'Juni', 'Juli', 'Aug.', 'Sep.', 'Okt.', 'Nov.', 'Dez.') [$month]"/>
	</xsl:function>
	<xsl:template name="dateFormat">
		<xsl:if test="@month != ''">
			<xsl:value-of select="cv:month-name-de(@month)"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="@year"/>
	</xsl:template>
	<xsl:template match="date">
		<xsl:call-template name="dateFormat"/>
	</xsl:template>
	<xsl:template match="from">
		<xsl:call-template name="dateFormat"/>
	</xsl:template>
	<xsl:template match="to">
		<xsl:text> - </xsl:text>
		<xsl:call-template name="dateFormat"/>
	</xsl:template>
	<xsl:template name="dateTemplate">
		<xsl:apply-templates select="from"/>
		<xsl:apply-templates select="to"/>
		<xsl:apply-templates select="date"/>
	</xsl:template>
</xsl:stylesheet>
