<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv.xml?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpa-functions"
                xmlns:cv="http://cv">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>

    <xsl:key name="skillref" match="//skill" use="@id"/>

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
            <xsl:apply-templates select="birthday|hometown|maritalStatus|contact"/>
        </div>
    </xsl:template>

    <xsl:template match="birthday">
        <div class="info birthday">
            <div class="label">
                <xsl:text>Geburtsdatum</xsl:text>
            </div>
            <div class="value">
                <xsl:call-template name="dateFormat"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="hometown">
        <div class="info hometown">
            <div class="label">
                <xsl:text>Heimatort</xsl:text>
            </div>
            <div class="value">
                <xsl:value-of select="." />
            </div>
        </div>
    </xsl:template>

    <xsl:template match="maritalStatus">
        <div class="info maritalStatus">
            <div class="label">
                <xsl:text>Zivilstand</xsl:text>
            </div>
            <div class="value">
                <xsl:value-of select="." />
            </div>
        </div>
    </xsl:template>

    <xsl:template match="contact">
        <div class="infoGroup contact">
            <div class="info address">
                <div class="label">
                    <xsl:text>Adresse</xsl:text>
                </div>
                <div class="value">
                    <xsl:apply-templates select="address"/>
                </div>
            </div>
            <div class="info phone">
                <div class="label">
                    <xsl:text>Telefon</xsl:text>
                </div>
                <div class="value">
                    <xsl:for-each select="phone">
                        <xsl:apply-templates select="current()"/>
                    </xsl:for-each>
                </div>
            </div>
            <div class="info email">
                <div class="label">
                    <xsl:text>Email</xsl:text>
                </div>
                <div class="value">
                    <xsl:for-each select="email">
                        <xsl:apply-templates select="current()"/>
                    </xsl:for-each>
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
            <xsl:apply-templates select="title"/>
        </h2>
        <h3>
            <xsl:apply-templates select="experience"/>
            <xsl:text> Jahre Berufserfahrung</xsl:text>
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
        <div>
            <xsl:apply-templates select="skillgroup"/>
        </div>
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
                    <i><xsl:text>Solide Kenntnisse in: </xsl:text></i>
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
                    <i><xsl:text>Gute Kenntnisse in: </xsl:text></i>
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

    <xsl:template match="educations|career|trainings|certificats|projects|languages">
        <xsl:apply-templates select="@title"/>
        <xsl:call-template name="tableContent"/>
    </xsl:template>

    <xsl:template match="activity">
        <dl class="activity {@id} {skillrefs/@location} {skillrefs/@orientation}">
            <dt>
                <div>
                    <xsl:value-of select="title"/>
                </div>
                <div>
                    <xsl:call-template name="dateTemplate"/>
                </div>
            </dt>
            <dd>
                <div class="text">
                    <div class="logo">
                        <img src="{@logo}" />
                    </div>
                    <div class="description">
                        <xsl:value-of select="description" disable-output-escaping="yes"/>
                    </div>
                    <div class="link">
                        <a href="{@link}"><xsl:value-of select="@link"/></a>
                    </div>
                    <xsl:for-each select="certificate">
                        <div>
                            <i><xsl:text>Zertifikat: </xsl:text></i>
                            <xsl:apply-templates select="current()"/>
                        </div>
                    </xsl:for-each>
                </div>
                <xsl:apply-templates select="skillrefs"/>
            </dd>
        </dl>
    </xsl:template>

    <!-- expiriances -->
    <xsl:template match="experiences">
        <xsl:apply-templates select="@title"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="experiance">
        <xsl:apply-templates select="period"/>
    </xsl:template>
    <xsl:template match="period">
        <div class="experiance">
            <div class="header">
                <xsl:apply-templates select="company"/>
                <div class="function">
                    <div>
                        <h2>
                            <xsl:call-template name="dateTemplate"/>
                        </h2>
                    </div>
                    <div>
                        <h3 class="function">
                            <xsl:apply-templates select="function"/>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="period">
                <div class="description">
                    <div class="projects">
                        <xsl:apply-templates select="project"/>
                    </div>
                    <xsl:apply-templates select="skillrefs"/>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="project">
        <div class="project {@id}">
            <div class="header odd">
                <div class="value">
                    <div>
                        <xsl:apply-templates select="@title"/>
                    </div>
                </div>
            </div>
            <div class="content {skillrefs/@location} {skillrefs/@orientation}"  >
                <div class="value">
                    <div>
                        <ul>
                            <xsl:for-each select="activity">
                                <xsl:apply-templates select="current()" mode="project"/>
                            </xsl:for-each>
                        </ul>
                    </div>
                </div>
                <xsl:apply-templates select="skillrefs"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="skillrefs">
        <div class="skillrefs">
            <xsl:apply-templates select="skillref"/>
        </div>
    </xsl:template>

    <xsl:template match="skillref">
        <xsl:apply-templates select="key('skillref', .)" mode="skillref"/>
    </xsl:template>

    <xsl:template match="skill" mode="skillref">
        <div class="skillref">
            <xsl:choose>
                <xsl:when test="@logo">
                    <img src="{@logo}" alt="{@id}" title="{.}"/>
                </xsl:when>
                <xsl:otherwise>
                        <xsl:value-of select="." />
                </xsl:otherwise>
            </xsl:choose>
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
        </div>
    </xsl:template>

    <xsl:template match="skill[@level]">
        <dl>
            <dt>
                <div>
                    <xsl:apply-templates select="text()"/>
                </div>
            </dt>
            <dd>
                <div>
                    <xsl:choose>
                        <xsl:when test="@level='native'">
                            <xsl:text>Muttersprache</xsl:text>
                        </xsl:when>
                        <xsl:when test="@level='fluent'">
                            <xsl:text>Schriftlich und mündlich fliessend</xsl:text>
                        </xsl:when>
                        <xsl:when test="@level='good'">
                            <xsl:text>Schriftlich und mündlich gut</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </div>
            </dd>
        </dl>
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
        <h1 class="{current()}">
            <xsl:value-of select="current()"/>
        </h1>
    </xsl:template>
    <!--A Table with a row for each content-->
    <xsl:template name="tableContent">
        <ul class="table {local-name()}">
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
    <xsl:function name="cv:month-number">
        <xsl:param name="month"/>
        <xsl:sequence select="$month"/>
    </xsl:function>
    <xsl:template name="dateFormat">
        <xsl:if test="@day != ''">
            <xsl:apply-templates select="@day"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@style = 'text'">
                <xsl:apply-templates select="text()"/>
            </xsl:when>
            <xsl:when test="@month != '' and @style = 'plain'">
                <xsl:value-of select="@month"/>
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:when test="@month != ''">
                <xsl:value-of select="cv:month-name-de(@month)"/>
                <xsl:text> </xsl:text>
            </xsl:when>
        </xsl:choose>
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
