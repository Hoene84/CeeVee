<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv.xml?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpa-functions"
                xmlns:cv="http://cv">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>

    <!-- do a parent for inherit default font Attrs -->
    <xsl:template name="main">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- person -->
    <xsl:template match="person">
        <div class="person">
            <div class="image">
                <xsl:call-template name="personImg"/>
            </div>
            <div class="description">
                <div>
                    <xsl:call-template name="personHeader"/>
                </div>
                <div>
                    <xsl:call-template name="personInfos"/>
                </div>
            </div>
        </div>
    </xsl:template>
    <!-- text part of the person (left side) -->
    <xsl:template name="personInfos">
        <div class="infos">
            <div class="info birthday">
                <div class="label">
                    <xsl:text>Geburtsdatum</xsl:text>
                </div>
                <div class="value">
                    <xsl:apply-templates select="birthday"/>
                </div>
            </div>
            <div class="info hometown">
                <div class="label">
                    <xsl:text>Heimatort</xsl:text>
                </div>
                <div class="value">
                    <xsl:apply-templates select="hometown"/>
                </div>
            </div>
            <div class="info maritalStatus">
                <div class="label">
                    <xsl:text>Zivilstand</xsl:text>
                </div>
                <div class="value">
                    <xsl:apply-templates select="maritalStatus"/>
                </div>
            </div>
            <div class="infoGroup contact">
                <div class="info address">
                    <div class="label">
                        <xsl:text>Adresse</xsl:text>
                    </div>
                    <div class="value">
                        <xsl:apply-templates select="contact/address"/>
                    </div>
                </div>
                <div class="info phone">
                    <div class="label">
                        <xsl:text>Telefon</xsl:text>
                    </div>
                    <div class="value">
                        <xsl:for-each select="contact/phone">
                            <xsl:apply-templates select="current()"/>
                        </xsl:for-each>
                    </div>
                </div>
                <div class="info email">
                    <div class="label">
                        <xsl:text>Email</xsl:text>
                    </div>
                    <div class="value">
                        <xsl:for-each select="contact/email">
                            <xsl:apply-templates select="current()"/>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="personHeader">
        <h1>
            <xsl:apply-templates select="forename"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="name"/>
        </h1>
        <h2>
            <xsl:apply-templates select="experience"/>
            <xsl:text> Jahre Berufserfahrung</xsl:text>
        </h2>
        <h3>
            <xsl:apply-templates select="title"/>
        </h3>
    </xsl:template>
    
    <!-- image of the person (rigth side) -->
    <xsl:template name="personImg">
        <div class="centered">
            <img src="{//person/picture}" />
        </div>
    </xsl:template>

    <xsl:template match="address">
        <div>
                <xsl:apply-templates select="street"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="streetnumber"/>
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="zip"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="location"/>
        </div>
    </xsl:template>
    <xsl:template match="zip">
        <xsl:if test="/cv/@international=true()">
            <xsl:apply-templates select="@countryIsoCode"/>
            <xsl:text>-</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="phone">
        <div>
            <!--xsl:choose>
                <xsl:when test="@type = 'homePhone'">
                    <xsl:text>Privat: </xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'cellPhone'">
                    <xsl:text>Mobile: </xsl:text>
                </xsl:when>
                <xsl:when test="@type = 'businessPhone'">
                    <xsl:text>Geschäft: </xsl:text>
                </xsl:when>
            </xsl:choose-->
            <xsl:text>0</xsl:text>
            <xsl:if test="/cv/@international=true()">
                <xsl:text>0</xsl:text>
                <xsl:apply-templates select="countryCode"/>
                <xsl:text>-(0)</xsl:text>
            </xsl:if>
            <xsl:apply-templates select="areaCode"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="number"/>
        </div>
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
        <dl>
            <dt>
                <div>
                    <xsl:apply-templates select="../@title"/>
                </div>
            </dt>
            <dd>
                <div>
                    <xsl:text>Solide Kenntnisse in </xsl:text>
                    <xsl:for-each select="skill">
                        <xsl:apply-templates select="current()"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="@etc = true()">
                        <xsl:text>, etc.</xsl:text>
                    </xsl:if>
                </div>
            </dd>
        </dl>
    </xsl:template>
    <xsl:template match="goodskill">
        <dl>
            <dt>
                <div>
                    <xsl:text></xsl:text>
                </div>
            </dt>
            <dd>
                <div>
                    <xsl:text>Gute Kenntnisse in </xsl:text>
                    <xsl:for-each select="skill">
                        <xsl:apply-templates select="current()"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="@etc = true()">
                        <xsl:text>, etc.</xsl:text>
                    </xsl:if>
                </div>
            </dd>
        </dl>
    </xsl:template>

    <xsl:template match="educations|training|certificats|projects">
        <xsl:apply-templates select="@title"/>
        <xsl:call-template name="tableContent"/>
    </xsl:template>

    <xsl:template match="activity">
        <dl>
            <dt>
                <div>
                    <xsl:value-of select="title"/>
                </div>
                <div>
                    <xsl:call-template name="dateTemplate"/>
                </div>
            </dt>
            <dd>
                <div>
                    <xsl:apply-templates select="description"/>
                    <xsl:for-each select="certificate">
                        <div>
                            <xsl:text>Zertifikat: </xsl:text>
                            <xsl:apply-templates select="current()"/>
                        </div>
                    </xsl:for-each>
                </div>
            </dd>
        </dl>
    </xsl:template>

    <!-- expiriances -->
    <xsl:template match="experiences">
        <xsl:apply-templates select="@title"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="experiance">
        <div class="experiance">
            <xsl:apply-templates select="period"/>
        </div>
    </xsl:template>
    <xsl:template match="period">
        <h2 class="period">
            <xsl:apply-templates select="company"/>
        </h2>
        <div class="period">
            <h3>
                <xsl:call-template name="dateTemplate"/>
            </h3>
            <h4 class="function">
                <xsl:apply-templates select="function"/>
            </h4>
            <div class="projects">
                <xsl:apply-templates select="project"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="project">
        <div class="project">
            <div class="header odd">
                <div class="label">
                    <div>
                        <xsl:text>Projekt</xsl:text>
                    </div>
                </div>
                <div class="value">
                    <div>
                        <xsl:apply-templates select="@title"/>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="label">
                    <div>
                        <xsl:text>Aktivitäten</xsl:text>
                    </div>
                </div>
                <div class="value">
                    <div>
                        <ul>
                            <xsl:for-each select="activity">
                                <xsl:apply-templates select="current()" mode="project"/>
                            </xsl:for-each>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="activity" mode="project">
        <li>
            <div>
                <xsl:value-of select="current()"/>
            </div>
        </li>
    </xsl:template>
    <xsl:template match="company">
        <div class="company">
            <div class="logo">
                <img src="{@logo}" />
            </div>
            <div  class="name">
                <xsl:value-of select="@name" />
            </div>
        </div>
    </xsl:template>
    <!-- languages -->
    <xsl:template match="languages">
        <xsl:apply-templates select="@title"/>
        <xsl:call-template name="tableContent"/>
    </xsl:template>
    <xsl:template match="language">
        <dl>
            <dt>
                <div>
                    <xsl:apply-templates select="@name"/>
                </div>
            </dt>
            <dd>
                <div>
                    <xsl:apply-templates select="skill"/>
                </div>
            </dd>
        </dl>
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
        <ul class="table">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="hobby">
        <li>
            <div>
                <xsl:value-of select="current()"/>
            </div>
        </li>
    </xsl:template>
    <!-- references -->
    <xsl:template match="references">
        <div class="paragraph">
            <xsl:apply-templates select="@title"/>
            <xsl:if test="@ondemande = true()">
                <xsl:text>Auf Anfrage</xsl:text>
            </xsl:if>
            <xsl:for-each select="reference">
                <xsl:apply-templates select="current()"/>
            </xsl:for-each>
        </div>
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
    <!-- begin -->
    <xsl:template match="begin">
        <xsl:apply-templates select="@title"/>
        <xsl:text>Nach Vereinbarung, ab </xsl:text>
        <xsl:call-template name="dateTemplate"/>
        <xsl:if test="@immediatly = true()">
            <xsl:text>sofort</xsl:text>
        </xsl:if>
        <xsl:text> verfügbar</xsl:text>
    </xsl:template>
    <!-- formats titel at niveau 3 -->
    <xsl:template match="cv/*/@title">
        <h1>
            <xsl:value-of select="current()"/>
        </h1>
    </xsl:template>
    <!--A Table with a row for each content-->
    <xsl:template name="tableContent">
        <ul class="table">
            <xsl:for-each select="*">
                <xsl:if test="position() mod 2=0">
                    <li class="even">
                        <xsl:apply-templates select="current()"/>
                    </li>
                </xsl:if>
                <xsl:if test="position() mod 2=1">
                    <li class="odd">
                        <xsl:apply-templates select="current()"/>
                    </li>
                </xsl:if>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <!--Dates formatting (exclusion and order garanteed by schema)-->
    <xsl:function name="cv:month-name-de" as="xs:string?">
        <xsl:param name="month" as="xs:integer?"/>
        <xsl:sequence select="('Jan.', 'Feb.', 'März', 'Apr.', 'Mai', 'Juni', 'Juli', 'Aug.', 'Sep.', 'Okt.', 'Nov.', 'Dez.') [$month]"/>
    </xsl:function>
    <xsl:template name="dateFormat">
        <xsl:if test="@day != ''">
            <xsl:apply-templates select="@day"/>
            <xsl:text> </xsl:text>
        </xsl:if>        
        <xsl:if test="@month != ''">
            <xsl:value-of select="cv:month-name-de(@month)"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="@year"/>
    </xsl:template>
    <xsl:template match="date">
        <xsl:call-template name="dateFormat"/>
    </xsl:template>
    <xsl:template match="birthday">
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
