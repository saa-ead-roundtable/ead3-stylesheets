<!-- EAD3 to PDF transformation.  Version: 0.6    Date: September 4, 2014   Author: Michael J. Fox-->

<!--Things you should know about this stylesheet.
	1.  This is a beta version.  It needs a lot of testing against various EAD3 instances.  The author offers no guarantees.
	2.  It is offered freely to the community but if you makes changes, take credit for them. 
	3.  Bugs, suggestions, and all manner of comments should be directed to the author at foxmjc@gmail.com.
	4.  This stylesheet was created and tested using Oxygen v. 15.1, Saxon v. 6.5.5, and the Apache FO processor packaged with that  verison of Oxygen.
			The XSLT syntax is that of version 1.0.
	5.  Given the range of practice that EAD3 accommodates, it is difficult to imagine all the variations that users might employ in markup. If the options 
		incorporated in this sytlesheet "break" your encoding, I'd love to hear from you with examples of the problems.
	6.  Not all of the new elements and attributes in EAD3 are fully supported at this time.  As examples of their use in the community are created and shared, and "best 
		practices" are promulgated, the author will attempt to fill in these lacunae.  This includes but is not limited to the "experimental" <relations> element 
		and the use of certain attributes within the children of <controlaccess> (persname, corpname, subject, geogname, etc.) intended to facilitate linked data.
	7.  <unitdatestructured> and <physdescstructured> also fall into the category of "show-me-your-markup-and-I'll-try-to-accommdate-it."  At this stage, the 
		author can only imagine how users will apply the markup options.
	8.  An attempt has been made to supply standard punctuation within the text of elements that serve as "access points" and make use of the <part> child 
	of the <controlaccess> children, e.g.  United States. Army. 101st Airborne Division-History-World War, 1939-1945-Personal narratives, American.
	9.  Additional comments are included adjacent to various templates.  If the syntax of a given template is unclear, please let me know. Hopefully I will be able to
	clear up your questions and make my notes in the stylesheet more expansive and clearer with regard to the question at issue.
	10.  As with stylesheets for the first two versions of EAD, four sets of elements are grouped together in the table of contents and in the
	body of the finding aid: access and use restrictions; separated and related materials; five elements containing administrative information; and seven 
	elements that contain information associated with the materials being described but which do not describe them per se.  These can easily be changed so that they 
	appear at the same level of presentation in the table of contents and the body of the finding aid as the major descriptive elements: scope and content, 
	administrative history or biography, and arrangement.
	11. Above all, I'd love to hear from you about the good, as well as the bad and downright ugly.
-->
 

<!-- *************************  TABLE OF CONTENTS FOR THE STYLESHEET ***********************************
																																						
SECTION 1: Layout of the four page types used.
		1a:   		Title page
		1b:   		Table of Contents page
		1c:   		<archdesc> pages
		1d.				<dsc> pages
SECTION 2: Generic attribute values
SECTION 3: Generic and named templates
		3a:				Orders the sequence of display for elements
		3b:				Populates the Table of Contents page
		3c:				Punctuates elements with <part> children
		3d:				Formats <parallelphysdescset>
		3e:				Formats <dao>
		3f:				Formats @render in <emph> and <title>
		3g:				Formats <list>
		3h:				Formats <chronlist>
SECTION 4: Formats <control>
SECTION 5: Formats <archdesc>/<did>
		5a:				Creates a table for <did> and sequences the <did> children
		5b:				Formats <repository> and <origination> 
		5c: 			Formats <unitid>, <unititle>, <unidate>, <physdesc>
							<abstract>, <physloc>, and <materialspec>
		5d:				Formats <unitdatestructured>
		5e:				Formats <physdescstructured>
		5f:				Formats <paralellphysdescset>
		5g:				Formats <langmaterial>
		5h:				Formats <didnote>
SECTION 6:	Formats <archdesc> children other than <did>
		6a:				Formats <bioghist>, <scopecontent>, <phystech>, 
							<arrangement>, <altformavail>
		6b:				Formats recursive <bioghist> and <scopecontent>
		6c:				Formats <list> within <arrangement>	
SECTION 7:	Formats <controlaccess>
		7a:				Formats <head> and <p>
		7b:				Formats non-recursive <controlaccess>
		7c:				Formats recursive <controlaccess>							
SECTION 8:	Formats <relatedmaterial> and <separatedmaterial>
SECTION 9:	Formats <accessrestrict> and <userestrict>
SECTION 10:	Formats administrative information:
							<custodhist>, <acqinfo>, <processinfo>
							<appraisal>, and <accruals>
SECTION 11:	Formats associated information
							<prefercite>, <otherfindaid>, <fileplan>,
							<originalsloc>, <legalstatus>, <odd>, <bibliography>, and <index>
SECTION 12:	Formats <index>
SECTION 13:	Formats <dsc>/head and <dsc>/<p>
SECTION 14: Formats <unitid>, <unittitle>, <unitdate>, <unitdatestructured>
							<physdesc>, <physdescstructured>, and <parallelphysdescset>
							for all component level
SECTION 15:	Formats components
	15a:			Formats <c01>
	15b:			Formats <c02>
	15c:			Formats <c03>
	15d:			Formats <c04>
	15e:			Formats <c05>
	15f:			Formats <c06>
	15g:			Formats <c07>
	15h:			Formats <c08>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:ead="http://ead3.archivists.org/schema/" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:strip-space elements="*"/>
	<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>



	<!--***********SECTION 1: SPECIFIES THE LAYOUT OF THE FOUR DIFFERENT TYPES OF PAGES INTO WHICH THE CONTENT OF THE FINDING AID WILL FLOW.******-->

	<!-- Creates the body of the finding aid.-->
	<xsl:template match="ead:ead">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="titlepage" page-height="11in" page-width="8.5in">
					<fo:region-body margin="20mm 20mm 20mm 20mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="toc" page-height="11in" page-width="8.5in">
					<fo:region-body margin="20mm 20mm 20mm 20mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="pages" page-height="11in" page-width="8.5in"
					margin="5mm 25mm 5mm 25mm">
					<fo:region-body margin="20mm 0mm 20mm 0mm"/>
					<fo:region-before extent="10mm"/>
					<fo:region-after extent="10mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="dsc" page-height="11in" page-width="8.5in"
					margin="5mm 25mm 5mm 25mm">
					<fo:region-body margin="20mm 0mm 20mm 0mm"/>
					<fo:region-before extent="10mm"/>
					<fo:region-after extent="10mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>

<!--**********SECTION 1A:  FORMATS THE TITLE PAGE.  ***********-->

			<fo:page-sequence master-reference="titlepage">
				<fo:flow flow-name="xsl-region-body">

					<fo:block space-before="2in" text-align="center">
						<fo:external-graphic src="INSERT YOUR LOGO HERE"/>
					</fo:block>

					<xsl:for-each select="ead:archdesc/ead:did/ead:repository/ead:corpname/ead:part | 
						ead:archdesc/ead:did/ead:repository/ead:persname/ead:part | 
						ead:archdesc/ead:did/ead:repository/ead:famname/ead:part">
						<fo:block font-size="14pt" font-family="Times" font-weight="bold" space-before=".5in"
							space-after=".5in" text-align="center">
							<xsl:apply-templates/>
						</fo:block>
					</xsl:for-each>

					<fo:block space-before="1.5in" font-size="14pt" font-family="Times" font-weight="bold"
						text-align="center">
						<xsl:value-of select="ead:control/ead:filedesc/ead:titlestmt/ead:titleproper"/>
					</fo:block>
					<fo:block space-before="0.25in" font-size="14pt" font-family="Times" font-weight="bold"
						text-align="center">
						<xsl:value-of select="ead:control/ead:filedesc/ead:titlestmt/ead:subtitle"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>

<!--************SECTION 1B:  FORMATS OF THE TABLE OF CONTENTS PAGE.***********************************************-->


			<fo:page-sequence master-reference="toc">
				<fo:static-content flow-name="xsl-region-before">
					<fo:block text-align="center" font-family="Times" font-size="10pt" font-weight="bold"/>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<fo:block font-size="16pt" font-family="sans-serif" font-weight="bold" space-before="5pt"
						space-after="15pt" keep-with-next.within-page="always" text-align="center"> Table of
						Contents</fo:block>
					<xsl:call-template name="toc"/>
				</fo:flow>
			</fo:page-sequence>

<!-- **********SECTION 1C:  SPECIFIES THE FORMAT OF THE PAGES THAT CONTAIN ARCDESC.  **********************************-->

<!-- This first section defines the format of the footer for <archdesc> children  -->
			<fo:page-sequence master-reference="pages" initial-page-number="1">
				<fo:static-content flow-name="xsl-region-after">
					<fo:block  font-size="12pt"  text-align-last="justify">
						<fo:inline text-align="left">
							<xsl:value-of select="ead:archdesc/ead:did/ead:unittitle"/>
						</fo:inline>
						<fo:leader leader-pattern="space"/>
						<fo:inline>
							<xsl:text>Page </xsl:text>
							<fo:page-number/>
						</fo:inline>
					</fo:block>
				</fo:static-content>
				
				<!-- Defines the format for the body of the <archdesc> section. -->
				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="findaid"/>
				</fo:flow>
			</fo:page-sequence>

<!-- **********SECTION 1D:  SPECIFIES THE CONTENT THE PAGES THAT CONTAIN THE DSC    ***************-->
			
			<!-- This first section defines the format of the footer for <dsc> children.  -->
			<fo:page-sequence master-reference="dsc">
				<fo:static-content flow-name="xsl-region-after">
					<fo:block  font-size="12pt"  text-align-last="justify">
						<fo:inline text-align="left">
							<xsl:value-of select="ead:archdesc/ead:did/ead:unittitle"/>
						</fo:inline>
						<fo:leader leader-pattern="space"/>
						<fo:inline>
							<xsl:text>Page </xsl:text>
							<fo:page-number/>
						</fo:inline>
					</fo:block>
				</fo:static-content>
					
					<!-- Defines the format for the body of the <dsc> section paes. -->
				<fo:flow flow-name="xsl-region-body">
					<xsl:apply-templates select="ead:archdesc/ead:dsc"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--***********SECTION 2: DEFINES SETS OF GENERIC ATTRIBUTE VALUES THAT WILL BE APPLIED AT VARIOUS POINTS IN THE STYLESHEET.******************-->

	<xsl:attribute-set name="divIndent25">
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-family">Times</xsl:attribute>
		<xsl:attribute name="margin-left">25pt</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
		<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="divIndent50">
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-family">Times</xsl:attribute>
		<xsl:attribute name="margin-left">50pt</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
		<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="component">
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-family">Times</xsl:attribute>
		<xsl:attribute name="space-before">15pt</xsl:attribute>
		<xsl:attribute name="space-after">15pt</xsl:attribute>
		<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h2">
		<xsl:attribute name="font-size">16pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">19pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h3">
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">14pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h4">
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="box-folder">
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">10pt</xsl:attribute>
		<xsl:attribute name="space-after">10pt</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
	</xsl:attribute-set>

	<!--***********SECTION 3: SPECIFIES THE CONTENT OF SEVERAL GENERIC AND NAMED TEMPLATES THAT WILL BE APPLIED AT VARIOUS POINTS IN THE STYLESHEET.******-->

<!-- ********** SECTION 3A.  ORDERS THE SEQUENCE OF ELEMENTS IN THE EAD INSTANCE.-->
	
	<xsl:template name="findaid">
		<!--To change the order of display, adjust the sequence of
			the following apply-template statements which invoke the various
			templates that populate the finding aid.  In several cases where
			multiple elemnents are displayed together in the output, a call-template
			statement is used-->
		<xsl:apply-templates select="ead:archdesc/ead:did"/>
		<xsl:apply-templates select="ead:archdesc/ead:bioghist"/>
		<xsl:apply-templates select="ead:archdesc/ead:scopecontent"/>
		<xsl:apply-templates select="ead:archdesc/ead:arrangement"/>
		<xsl:apply-templates select="ead:archdesc/ead:phystech"/>
		<xsl:apply-templates select="ead:archdesc/ead:altformavail"/>
		<xsl:call-template name="archdesc-restrict"/>
		<xsl:apply-templates select="ead:archdesc/ead:controlaccess"/>
		<xsl:call-template name="archdesc-relatedmaterial"/>
		<xsl:call-template name="archdesc-admininfo"/>
		<xsl:call-template name="associated-information"/>
	</xsl:template>

<!-- ********* SECTION 3B. POPULATES THE TABLE OF CONTENTS PAGE -->

	<xsl:template name="toc">
		<xsl:if test="string(ead:archdesc/ead:did/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:did/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:did/ead:head)}"/>
			</fo:block>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:bioghist/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:bioghist/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:bioghist/ead:head)}"/>
			</fo:block>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:scopecontent/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:scopecontent/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:scopecontent/ead:head)}"/>
			</fo:block>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:arrangement/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:arrangement/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:arrangement/ead:head)}"/>
			</fo:block>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:phystech/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:phystech/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:phystech/ead:head)}"/>
			</fo:block>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:altformavail/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:altformavail/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:altformavail/ead:head)}"/>
			</fo:block>
		</xsl:if>
		<!-- Groups userestrict and accessrestrict -->
		<xsl:if
			test="string(ead:archdesc/ead:userestrict/ead:head)
			or string(ead:archdesc/ead:accessrestrict/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:text>Restrictions</xsl:text>
				<fo:leader leader-pattern="dots"/>
				<fo:inline text-align="right">
					<fo:page-number-citation ref-id="restrictlink"/>
				</fo:inline>
			</fo:block>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:controlaccess/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:controlaccess/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:controlaccess/ead:head)}"/>
			</fo:block>
		</xsl:if>
		
		<!-- Groups related and separated material -->
		
		<xsl:if
			test="string(ead:archdesc/ead:relatedmaterial/ead:*) 
			or string(ead:archdesc/ead:separatedmaterial/ead:*)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:text>Related Material</xsl:text>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="relatedmatlink"/>
			</fo:block>
		</xsl:if>
		
		<!-- Groups a series of elements with administrative information. -->
		<xsl:if
			test="string(ead:archdesc/ead:acqinfo/ead:*)
			or string(ead:archdesc/ead:processinfo/ead:*)
   			or string(ead:archdesc/ead:custodialhist/ead:*)
			or string(ead:archdesc/ead:appraisal/ead:*)
			or string(ead:archdesc/ead:accruals/ead:*)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:text>Administrative Information</xsl:text>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="adminlink"/>
			</fo:block>
		</xsl:if>

		<!-- Groups a series of elements with information associated rther than 
			directly about the materials being described . -->

		<xsl:if
			test="string(ead:archdesc/ead:otherfindaid/ead:*)
			or string(ead:archdesc/ead:bibliography/ead:*)
			or string(ead:archdesc/ead:prefercite/ead:*)
			or string(ead:archdesc/ead:fileplan/ead:*)
			or string(ead:archdesc/ead:originalsloc/ead:*)
			or string(ead:archdesc/ead:index/ead:*)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:text>Associated Information</xsl:text>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="associatedlink"/>
			</fo:block>
		</xsl:if>

<!-- Adds the dsc head and component children to the table of contents. -->

		<xsl:if test="string(ead:archdesc/ead:dsc/ead:head)">
			<fo:block xsl:use-attribute-sets="h4" text-align-last="justify">
				<xsl:value-of select="ead:archdesc/ead:dsc/ead:head"/>
				<fo:leader leader-pattern="dots"/>
				<fo:page-number-citation ref-id="{generate-id(ead:archdesc/ead:dsc/ead:head)}"/>
			</fo:block>
			<!-- Displays the unittitle and unitdates for a ead:c01 if it is a
			subgrp, subcollection, series or subseries (as
			evidenced by the value of @level) and numbers them
			to form a hyperlink to each.   Delete this section if you do not
			wish the c01 titles that are so identified
			to appear in the table of contents.-->
			<xsl:for-each
				select="ead:archdesc/ead:dsc/ead:c01[@level='series' or @level='subseries'
			or @level='subgrp' or @level='subcollection']">
				<fo:block xsl:use-attribute-sets="h4" text-align-last="justify" margin-left="25pt">
					<xsl:value-of select="ead:did/ead:unittitle"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="ead:did/ead:unitdate"/>
					<fo:leader leader-pattern="dots"/>
					<fo:page-number-citation ref-id="{generate-id(ead:did)}"/>
				</fo:block>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>


<!-- ********* SECTION 3C.  FORMATS AND SUPPLIES PUNCTUATIN OF THE ACCESS ELEMENTS THAT HAVE A 	CHILD PART ELEMENTS AS FOUND IN REPOSITORY, ORIGINATION, and CONTROLACCESS. -->

	
	<xsl:template
		match="ead:persname/ead:part | ead:corpname/ead:part | ead:famname/ead:part | 
		ead:name/ead:part | ead:subject/ead:part | ead:title/ead:part | ead:function/ead:part
		| ead:occupation/ead:part | ead:geogname/ead:part | ead:genreform/ead:part">

		<!-- Punctuation is generic when a MARC-based @localtype is not supplied.-->
		<xsl:choose>
			<xsl:when test="not[@localtype]">
				<xsl:apply-templates/>
				<xsl:text>.&#x20;</xsl:text>
			</xsl:when>
			
<!-- Otherwise supply punctuation based on MARC 21 attribut values. -->
						
			<xsl:when test="position()!=last() and @localtype!='q'">
				<xsl:apply-templates/>
				<xsl:if
					test="following-sibling::ead:part[1][@localtype='v'] or following-sibling::ead:part[1][@localtype='x'] 
						or following-sibling::ead:part[1][@localtype='y'] or following-sibling::ead:part[1][@localtype='z']">
					<xsl:text>--</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype='b']">
					<xsl:text>.&#x20;</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype='q']">
					<xsl:text>&#x20;(</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype='d']">
					<xsl:text>,&#x20;</xsl:text>
				</xsl:if>
			</xsl:when>

			<xsl:when test="position()!=last() and @localtype='q'">
				<xsl:apply-templates/>
				<xsl:text>),&#x20;</xsl:text>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:text>.&#x20;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

<!-- ********** SECTION 3D.  FORMATS PARALLELPHYSDESCSET ********************************************-->
		
<!--Multiple encoding options are possible with this element.  This template does not attempt to process all conceivable scenarios.
	It concatenates multiiple physdescstructred elements into a single string. -->

	<!-- This template assumes that if there are multiple <physdescstructured> elements, 
	they are wraped in a parent <parallelphydescset> element.-->

	<xsl:template name="parallel-physdesc">
		<xsl:choose>
			<xsl:when
				test="position()='1' and ./@physdescstructuredtype='spaceoccupied' and ./@coverage='whole'">

				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>

				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype='carrier' and @coverage='whole']">
					<xsl:text>in  </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='carrier']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='carrier']/ead:unittype"/>
				</xsl:if>
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype='materialtype']">
					<xsl:text> and consisting of </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='materialtype']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='materialtype']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<xsl:when
				test="position()='1' and ./@physdescstructuredtype='carrier' and ./@coverage='whole'">

				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>

				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype='spaceoccupied']">
					<xsl:text> occupying </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='spaceoccupied']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='spaceoccupied']/ead:unittype"/>
				</xsl:if>
				<xsl:if
					test="following-sibling::ead:physdescstructured/@physdescstructuredtype='materialtype'">
					<xsl:text> and consisting of </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='materialtype']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='materialtype']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<xsl:when
				test="position()='1' and ./@physdescstructuredtype='materialtype' and ./@coverage='whole'">

				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>

				<xsl:if test="following-sibling::ead:physdescstructured[@coverage='whole']">
					<xsl:text> in </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='carrier']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='carrier']/ead:unittype"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype='spaceoccupied']">
					<xsl:text>  occupying </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='spaceoccupied']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:value-of
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype='spaceoccupied']/ead:unittype"/>
				</xsl:if>
			</xsl:when>

			<xsl:otherwise>
				<!--Suppress additional physdescstructured elements in position 2 and 3 as they have already been processed.-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!--********** 3E. FORMATS DAO ******************************************************-->	

	<!--The following template formats the dao element.-->
	<xsl:template match="ead:dao">
		<fo:block space-before=".5in" text-align="center">
			<fo:external-graphic src="{href}"/>
		</fo:block>
		<fo:block space-before=".5in" text-align="center">
			<xsl:apply-templates select="ead:daodesc"/>
			<fo:external-graphic src="YOUR LOGO HERE"/>
		</fo:block>
	</xsl:template>
	
<!-- ********** 3F.  FORMATS @RENDER IN TITLE AND EMPH.  ************************************* -->


	<!-- The following general templates format the display of various RENDER attributes.-->
	<xsl:template match="ead:emph[@render='bold']">
		<fo:inline font-weight="bold">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='italic']">
		<fo:inline font-style="italic">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='underline']">
		<fo:inline text-decoration="underline">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='sub']">
		<fo:inline vertical-align="sub">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='super']">
		<fo:inline vertical-align="super">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='quoted']">
		<fo:inline>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='doublequote']">
		<fo:inline>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='singlequote']">
		<fo:inline>
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='bolddoublequote']">
		<fo:inline font-weight="bold">
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='boldsinglequote']">
		<fo:inline font-weight="bold">
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='boldunderline']">
		<fo:inline font-weight="bold" text-decoration="underline">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='bolditalic']">
		<fo:inline font-weight="bold" font-style="italic">> <xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='boldsmcaps']">
		<fo:inline font-weight="bold" font-variant="small-caps">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:emph[@render='smcaps']">
		<fo:inline font-variant="small-caps">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='bold']">
		<fo:inline font-weight="bold">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='italic']">
		<fo:inline font-style="italic">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='underline']">
		<fo:inline text-decoration="underline">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='sub']">
		<fo:inline vertical-align="sub">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='super']">
		<fo:inline vertical-align="super">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='quoted']">
		<fo:inline>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='doublequote']">
		<fo:inline>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='singlequote']">
		<fo:inline>
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='bolddoublequote']">
		<fo:inline font-weight="bold">
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='boldsinglequote']">
		<fo:inline font-weight="bold">
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='boldunderline']">
		<fo:inline font-weight="bold" text-decoration="underline">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='bolditalic']">
		<fo:inline font-weight="bold" font-style="italic">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='boldsmcaps']">
		<fo:inline font-weight="bold" font-variant="small-caps">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="ead:title[@render='smcaps']">
		<fo:inline font-variant="small-caps">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>


<!--********** 3G.  FORMATS A LIST ELEMENT ANYWHERE EXCEPT IN ARRANGEMENT.**********************************************-->
	
	<!-- THIS TEMPLATE WILL BENEFIT FROM FURTHER TESTING-->
	
	<xsl:template match="ead:list[parent::*[not(self::ead:arrangement)]]/ead:head">
		<fo:block xsl:use-attribute-sets="divIndent25">
			<fo:inline font-weight="bold">
				<xsl:apply-templates/>
			</fo:inline>
		</fo:block>
	</xsl:template>
	<xsl:template match="ead:list[parent::*[not(self::ead:arrangement)]]/ead:item">
		<fo:block xsl:use-attribute-sets="divIndent50">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>


<!-- ********** 3H.   FORMATS A CHRONLIST ELEMENT.   *********************************************************************-->
	
	<!-- THIS TEMPLATE WILL BENEFIT FROM FURTHER TESTING-->
	
	<xsl:template match="ead:chronlist">
		<fo:table width="100%" style="margin-left:25pt">
			<fo:table-column column-width="5%"/>
			<fo:table-column column-width="15%"/>
			<fo:table-column column-width="80%"/>
			<fo:table-body>
				<xsl:apply-templates/>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template match="ead:chronlist/ead:head">
		<fo:table-row>
			<fo:table-cell number-columns-spanned="3">
				<fo:block xsl:use-attribute-sets="h4">
					<xsl:apply-templates/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	<xsl:template match="ead:chronlist/ead:listhead">
		<fo:table-row>
			<fo:table-cell>
				<fo:block> </fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:inline font-weight="bold">
					<xsl:apply-templates select="ead:head01"/>
				</fo:inline>
			</fo:table-cell>
			<fo:table-cell>
				<fo:inline font-weight="bold">
					<xsl:apply-templates select="ead:head08"/>
				</fo:inline>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	<xsl:template match="ead:chronitem">
		<!--Determine if there are event groups.-->
		<xsl:choose>
			<xsl:when test="ead:eventgrp">
				<!--Put the date and first event on the first line.-->
				<fo:table-row>
					<fo:table-cell>
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top">
						<xsl:apply-templates select="ead:date"/>
					</fo:table-cell>
					<fo:table-cell vertical-align="top">
						<xsl:apply-templates select="ead:eventgrp/ead:event[position()=1]"/>
					</fo:table-cell>
				</fo:table-row>
				<!--Put each successive event on another line.-->
				<xsl:for-each select="ead:eventgrp/ead:event[not(position()=1)]">
					<fo:table-row>
						<fo:table-cell>
							<fo:block> </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block> </fo:block>
						</fo:table-cell>
						<fo:table-cell vertical-align="top">
							<xsl:apply-templates select="."/>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
			</xsl:when>
			<!--Put the date and event on a single line.-->
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell>
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top">
						<xsl:apply-templates select="ead:date"/>
					</fo:table-cell>
					<fo:table-cell vertical-align="top">
						<xsl:apply-templates select="ead:event"/>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<!-- ************************************SECTION 4: FORMATS THE CONTROL ELEMENT*************************************-->

	<!--Suppreses all elements of control that do not appear on the title page.-->
	<xsl:template match="ead:control"/>


	<!-- ***********************************SECTION 5: FORMATS THE ARCHDESC/DID  ELEMENT******************************-->


<!--********** 5A.  CREATES A TABLE FOR THE DID AND SEQUNCES THE ORDER OF PRESENTATION FOR ITS CHILDREN.  *********************-->
		
<!-- 	This template creates a table for the did, inserts the head and then
each of the other did elements.  To change the order of appearance of these
elements, change the sequence of the apply-templates statements.-->


	<xsl:template match="ead:archdesc/ead:did">
		<fo:table width="7in" table-layout="fixed">
			<fo:table-column column-width="1in"/>
			<fo:table-column column-width="6in"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell number-columns-spanned="2">
						<fo:block xsl:use-attribute-sets="h3" id="{generate-id(ead:head)}">
							<xsl:apply-templates select="ead:head"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<!--One can change the order of appearance for the children of ead:did
				by changing the order of the following statements.-->
				<xsl:apply-templates select="ead:repository"/>
				<xsl:apply-templates select="ead:origination"/>
				<xsl:apply-templates select="ead:unittitle"/>
				<xsl:apply-templates select="ead:unitdate"/>
				<xsl:apply-templates select="ead:unitdatestructured"/>
				<xsl:apply-templates select="ead:physdesc"/>
				<xsl:apply-templates select="ead:physdescstructured"/>
				<xsl:apply-templates select="ead:parallelphysdescset"/>
				<xsl:apply-templates select="ead:abstract"/>
				<xsl:apply-templates select="ead:unitid"/>
				<xsl:apply-templates select="ead:physloc"/>
				<xsl:apply-templates select="ead:langmaterial"/>
				<xsl:apply-templates select="ead:materialspec"/>
				<xsl:apply-templates select="ead:didnote"/>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
<!--********** 5B.  FORMATS REPOSITORY AND ORIGINATION. ****************************************************** -->

	<!-- Repository and origination are processed first and separately because their descendant <part> 
	is unique among the <did> children.-->

	<xsl:template
		match="ead:archdesc/ead:did/ead:repository/ead:corpname 
		| ead:archdesc/ead:did/ead:origination/ead:persname
		| ead:archdesc/ead:did/ead:origination/ead:famname">

		<!--The portion of the template tests to see if there is a label attribute,
		inserting the contents if there is or adding display text if there isn't.
		The content of the supplied label depends on the element.  To change the
		supplied label, simply alter the template below.-->
		<xsl:choose>
			<xsl:when test="parent::ead:*[@label]">
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:value-of select="parent::ead:*/@label"/>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:choose>
									<xsl:when test="parent::ead:repository">
										<xsl:text>Repository: </xsl:text>
									</xsl:when>
									<xsl:when test="parent::ead:origination">
										<xsl:text>Creator: </xsl:text>
									</xsl:when>
								</xsl:choose>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!-- ********** 5C.  FORMATS UNITTITLE, UNITDATE, PHYSDESC ABSTRACT, UNITID, PHYSLOC, AND MATERIALSPEC.  ***********************************************  -->	
	
	<!-- These elements share a common presentaiton in this stylesheet.
		The other <did> children are handled by separate templates that follow.-->

	<xsl:template
		match="ead:archdesc/ead:did/ead:unittitle 
	| ead:archdesc/ead:did/ead:unitdate 
	| ead:archdesc/ead:did/ead:physdesc
	| ead:archdesc/ead:did/ead:unitid
	| ead:archdesc/ead:did/ead:physloc
	| ead:archdesc/ead:did/ead:abstract
		| ead:archdesc/ead:did/ead:materialspec">


		<!--The portion of the template tests to see if there is a label attribute,
		inserting the contents if there is or adding text supplied by the stylesheet if there isn't.
		The content of the supplied label depends on the element.-->  
	
		<xsl:choose>
			<xsl:when test="@label">
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:value-of select="@label"/>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								
			<!--To change the stylesheet supplied labels, simply alter the following section. -->							
								<xsl:choose>
									<xsl:when test="self::ead:unittitle">
										<xsl:text>Title: </xsl:text>
									</xsl:when>
									<xsl:when test="self::ead:unitdate">
										<xsl:text>Dates: </xsl:text>
									</xsl:when>
									<xsl:when test="self::ead:physdesc">
										<xsl:text>Quantity: </xsl:text>
									</xsl:when>
									<xsl:when test="self::ead:unitid">
										<xsl:text>Identification: </xsl:text>
									</xsl:when>
									<xsl:when test="self::ead:physloc">
										<xsl:text>Location: </xsl:text>
									</xsl:when>
									<xsl:when test="self::ead:abstract">
										<xsl:text>Abstract: </xsl:text>
									</xsl:when>
									<xsl:when test="self::ead:materialspec">
										<xsl:text>Technical: </xsl:text>
									</xsl:when>
								</xsl:choose>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!-- ******** 5D.  FORMATS UNITDATESTRUCTURED    ******************************************************** -->	

	<xsl:template match="ead:archdesc/ead:did/ead:unitdatestructured">
		<xsl:choose>
			<xsl:when test="@label">
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:value-of select="@label"/>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates select="ead:daterange/ead:fromdate"/>
							<xsl:text>-</xsl:text>
							<xsl:apply-templates select="ead:daterange/ead:todate"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:text>Dates: </xsl:text>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates select="ead:daterange/ead:fromdate"/>
							<xsl:text>-</xsl:text>
							<xsl:apply-templates select="ead:daterange/ead:todate"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!-- ********** 5E.  FORMATS PHYSDESCSTRUCTURED.  ********************************************************************* -->	

	<xsl:template match="ead:archdesc/ead:did/ead:physdescstructured">
		<!-- This option processes phydescstructured elements that are not a child of parallelphysdescset.-->
		<xsl:choose>
			<xsl:when test="@label">
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:value-of select="@label"/>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates select="ead:quantity"/>
							<xsl:text>&#x20;</xsl:text>
							<xsl:apply-templates select="ead:unittype"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:text>Quantity: </xsl:text>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates select="ead:quantity"/>
							<xsl:text>&#x20;</xsl:text>
							<xsl:apply-templates select="ead:unittype"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ********** 5F.  FORMATS PARALELLPHYSDESCSET **************************************************************** -->

	<xsl:template match="ead:archdesc/ead:did/ead:parallelphysdescset">
		<xsl:for-each select="ead:physdescstructured[1]">
			<xsl:choose>
				<xsl:when test="@label">
					<fo:table-row>
						<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
							<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
								<fo:inline font-weight="bold">
									<xsl:value-of select="@label"/>
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
							<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
								<xsl:call-template name="parallel-physdesc"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
							<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
								<fo:inline font-weight="bold">
									<xsl:text>Quantity: </xsl:text>
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
							<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
								<xsl:call-template name="parallel-physdesc"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

<!-- ********** 5G.  FORMATS LANGMATERIAL ************************************************************   -->

	<xsl:template match="ead:archdesc/ead:did/ead:langmaterial">
		<xsl:for-each select="ead:language"/>
		<xsl:choose>
			<xsl:when test="@label">
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:value-of select="@label"/>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block margin-left="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates select="ead:descriptivenote/ead:p"/>

						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<fo:inline font-weight="bold">
								<xsl:text>Language: </xsl:text>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
						<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
							<xsl:apply-templates select="ead:quantity"/>
							<xsl:text>&#x20;</xsl:text>
							<xsl:apply-templates select="ead:carrier"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	
<!-- ********** 5H.  FORMATS DIDNOTE ***************************************************************   -->	

	<xsl:template match="ead:archdesc/ead:did/ead:didnote">
		<xsl:for-each select="ead:didnote">

			<!--The template tests to see if there is a label attribute, inserting the contents if there is or adding one if there isn't. -->
			<xsl:choose>
				<xsl:when test="parent::ead:didnote[@label]">
					<!--This nested choose tests for and processes the first paragraph. Additional paragraphs do not get a label.-->
					<xsl:choose>
						<xsl:when test="position()=1">
							<fo:table-row>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
									<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
										<fo:inline font-weight="bold">
											<xsl:value-of select="@label"/>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
									<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
										<xsl:apply-templates/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:when>
						<xsl:otherwise>
							<fo:table-row>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt"/>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
									<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
										<xsl:apply-templates/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!--Processes situations where there is no label attribute by supplying default text.-->
				<xsl:otherwise>
					<!--This nested choose tests for and processes the first paragraph. Additional paragraphs do not get a label.-->
					<xsl:choose>
						<xsl:when test="position()=1">
							<fo:table-row>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
									<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
										<fo:inline font-weight="bold">
											<xsl:text>Note: </xsl:text>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
									<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
										<xsl:apply-templates/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:when>
						<xsl:otherwise>
							<fo:table-row>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt"/>
								<fo:table-cell vertical-align="top" padding-bottom="5pt" padding-top="5pt">
									<fo:block text-indent="25pt" font-family="Times" font-size="11pt">
										<xsl:apply-templates/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<!--Closes each <didnote>-->
		</xsl:for-each>
	</xsl:template>



	<!--************SECTION 6: FORMATS ARCHDESC CHILDREN OTHER THAN DID.   **************************************************************-->
	
	<!-- ********** 6A. FORMATS BIOGHIST, SCOPECONTENT, PHYSTECH, ARRANGEMENT, AND ALTFORMAVAIL.  **********  -->
		
	<!--This template creates a link back to the top of the page after the display of the element.-->
	<xsl:template
		match="ead:archdesc/ead:bioghist |
			ead:archdesc/ead:scopecontent |
			ead:archdesc/ead:phystech |
			ead:archdesc/ead:arrangement |
			ead:archdesc/ead:altformavail">
		<xsl:if test="string(child::ead:*)">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>
	<!--This template formats various ead:head elements and makes them targets for
		links from the Table of Contents.-->
	<xsl:template
		match="ead:archdesc/ead:bioghist/ead:head  |
			ead:archdesc/ead:scopecontent/ead:head |
			ead:archdesc/ead:phystech/ead:head |
			ead:archdesc/ead:arrangement/ead:head">
		<fo:block xsl:use-attribute-sets="h3" id="{generate-id()}">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template
		match="ead:archdesc/ead:bioghist/ead:p |
		ead:archdesc/ead:scopecontent/ead:p |
		ead:archdesc/ead:phystech/ead:p |
		ead:archdesc/ead:arrangement/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent25" keep-with-next.within-page="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

<!-- ********** 6B.  FORMATS RECURSIVE BIOGHIST AND SCOPEONTENT *********************************************** -->

	<xsl:template
		match="ead:archdesc/ead:bioghist/ead:bioghist/ead:head |
		ead:archdesc/ead:scopecontent/ead:scopecontent/ead:head">
		<fo:block xsl:use-attribute-sets="h3" id="{generate-id()}" margin-left="25pt">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>


	<xsl:template
		match="ead:archdesc/ead:bioghist/ead:bioghist/ead:p |
		ead:archdesc/ead:scopecontent/ead:scopecontent/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent50">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

<!--********** 6C.  FORMATS LIST WITHIN ARRANGEMENT.  ******************************************************** -->

	<xsl:template match="ead:archdesc/ead:arrangement/ead:list/ead:head">
		<fo:block xsl:use-attribute-sets="divIndent25" id="{generate-id()}">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="ead:archdesc/ead:arrangement/ead:list/ead:item">
		<fo:block xsl:use-attribute-sets="divIndent50">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>



<!--   *****************************SECTION 7: CONTROLACCESS ************************************************************ -->
	
<!-- ********** 7A.  FORMATS CONTROLACCESS HEAD AND P. ******************************* -->	

	<!--This template formats the top-level controlaccess element.
	It begins by testing to see if there is any controlled
	access element with content. It then invokes one of two templates
	for the children of ead:controlaccess.  -->


	<xsl:template match="ead:archdesc/ead:controlaccess">
		<xsl:if test="string(child::*)">
			<fo:block xsl:use-attribute-sets="h3" id="{generate-id(ead:head)}">
				<xsl:apply-templates select="ead:head"/>
			</fo:block>

			<fo:block xsl:use-attribute-sets="divIndent25">
				<xsl:apply-templates select="ead:p"/>
			</fo:block>
			
			<!-- Calls one of two named templates depending on whether controlaccess is used recursively or not. -->			
			<xsl:choose>
				<!--Apply this template when there are recursive ead:controlaccess 	elements.-->
				<xsl:when test="ead:controlaccess">
					<xsl:apply-templates mode="recursive" select="."/>
				</xsl:when>
				<!--Apply this template when the controlled terms are entered
				directly under the ead:controlaccess element.-->
				<xsl:otherwise>
					<xsl:apply-templates mode="direct" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
<!-- ********** 7B.  FORMATS NON-RECURSIVE CONTROLACCESS ************************************************ -->	

	<!--This template formats controlled terms that are entered
	directly under the controlaccess element.  Elements are alphabetized.-->
	<xsl:template mode="direct" match="ead:archdesc/ead:controlaccess">
		<xsl:for-each
			select="ead:subject |ead:corpname | ead:famname | ead:persname | ead:genreform | ead:title | ead:geogname | ead:occupation">
			<xsl:sort select="." data-type="text" order="ascending"/>
			<fo:block xsl:use-attribute-sets="divIndent50">
				<xsl:apply-templates/>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
<!-- ********** 7C.  FORMATS RECURSIVE CONTROLACCESS ***************************************************** -->		

		<xsl:template mode="recursive" match="ead:archdesc/ead:controlaccess">
		<xsl:apply-templates select="ead:head"/>
		<xsl:apply-templates select="ead:controlaccess"/>
	</xsl:template>

	<!--This template formats controlled terms that are nested within recursive
	controlaccess elements.   Terms are alphabetized within each grouping.-->
	<xsl:template match="ead:archdesc/ead:controlaccess/ead:controlaccess">
		<fo:block xsl:use-attribute-sets="h4" text-indent="25pt">
			<xsl:apply-templates select="ead:head"/>
		</fo:block>
		<xsl:for-each
			select="ead:subject |ead:corpname | ead:famname | ead:persname | ead:genreform | ead:title | ead:geogname | ead:occupation">
			<xsl:sort select="." data-type="text" order="ascending"/>
			<fo:block xsl:use-attribute-sets="divIndent50">
				<xsl:apply-templates/>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
<!--   *****************************SECTION 8: FORMATS RELATEDMATERIAL AND SEPARATED MATERIAL.  ************************************************************ -->
	

	<!--This template formats the top-level related and separatd material elements by combining any related or separated materials
	elements. It begins by testing to see if there related or separated materials elements with content.-->

	<xsl:template name="archdesc-relatedmaterial">
		<xsl:if
			test="string(ead:archdesc/ead:relatedmaterial) or
			string(ead:archdesc/ead:separatedmaterial)">
			<fo:block xsl:use-attribute-sets="h3" id="relatedmatlink">
				<fo:inline font-weight="bold">
					<xsl:text>Related Material</xsl:text>
				</fo:inline>
			</fo:block>
			<fo:block keep-together.within-page="always">
				<xsl:apply-templates select="ead:archdesc/ead:relatedmaterial/ead:p"/>
				<xsl:apply-templates select="ead:archdesc/ead:separatedmaterial/ead:p"/>
			</fo:block>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="ead:archdesc/ead:relatedmaterial/ead:p
		| ead:archdesc/ead:separatedmaterial/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent25">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<!--   *****************************SECTION 9: FORMATS ACCESSRESTRICT AND USERESTRICT  ************************************************************ -->
	

	<!--This template rule formats a top-level access and use retriction elements. 	They are displayed under a common heading. 
		It begins by testing to see if there are any restriction elements with content.-->
	<xsl:template name="archdesc-restrict">
		<xsl:if
			test="string(ead:archdesc/ead:userestrict/*)
		or string(ead:archdesc/ead:accessrestrict/*)">
			<fo:block xsl:use-attribute-sets="h3" id="restrictlink">
				<fo:inline font-weight="bold">
					<xsl:text>Restrictions</xsl:text>
				</fo:inline>
			</fo:block>
			<fo:block keep-together.within-page="always">
				<xsl:apply-templates select="ead:archdesc/ead:accessrestrict"/>
				<xsl:apply-templates select="ead:archdesc/ead:userestrict"/>
			</fo:block>
		</xsl:if>
	</xsl:template>


	<xsl:template
		match="ead:archdesc/ead:accessrestrict/ead:head
	| ead:archdesc/ead:userestrict/ead:head">
		<fo:block xsl:use-attribute-sets="h4" margin-left="25pt">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="ead:archdesc/ead:accessrestrict/ead:p
		| ead:archdesc/ead:userestrict/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent50" keep-with-next.within-page="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<!--   *****************************SECTION 10: FORMATS INFORMATION OF AN ADMINISTRATIVE NATURE ************************************************************ -->
	
	<!--This templates consolidates all the other administrative information
	 elements into one block under a common heading.  It formats these elements
	 regardless of which of three encodings has been utilized.  
	 It begins by testing to see if there are any elements of this type
	 with content.-->
	<xsl:template name="archdesc-admininfo">
		<xsl:if
			test="string(ead:archdesc/ead:custodhist/*)
		or string(ead:archdesc/ead:acqinfo/*)
		or string(ead:archdesc/ead:processinfo/*)
		or string(ead:archdesc/ead:appraisal/*)
		or string(ead:archdesc/ead:accruals/*)">

			<fo:block xsl:use-attribute-sets="h3" id="adminlink">
				<xsl:text>Administrative Information</xsl:text>
			</fo:block>
			<xsl:apply-templates select="ead:archdesc/ead:custodhist"/>
			<xsl:apply-templates select="ead:archdesc/ead:acqinfo"/>
			<xsl:apply-templates select="ead:archdesc/ead:processinfo"/>
			<xsl:apply-templates select="ead:archdesc/ead:appraisal"/>
			<xsl:apply-templates select="ead:archdesc/ead:accruals"/>
		</xsl:if>
	</xsl:template>



	<!--This template rule formats the ead:head element of top-level elements of
	administrative information.-->
	<xsl:template
		match="ead:archdesc/ead:custodhist/ead:head
		| ead:archdesc/ead:acqinfo/ead:head
		| ead:archdesc/ead:processinfo/ead:head
		| ead:archdesc/ead:appraisal/ead:head
		| ead:archdesc/ead:accruals/ead:head">
		<fo:block margin-left="25pt" xsl:use-attribute-sets="h4" id="{generate-id()}">
			<fo:inline font-weight="bold">
				<xsl:apply-templates/>
			</fo:inline>
		</fo:block>
	</xsl:template>
	<xsl:template
		match="ead:archdesc/ead:custodhist/ead:p
		| ead:archdesc/ead:acqinfo/ead:p
		| ead:archdesc/ead:processinfo/ead:p
		| ead:archdesc/ead:appraisal/ead:p
		| ead:archdesc/ead:accruals/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent50" keep-with-next.within-page="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
<!--   *****************************SECTION 11: FORMATS ASSOCIATED INFORMATION  ************************************************************ -->
	

	<!--This templates consolidates information associated with the materials being described
	 into a single block under a common heading.  It formats these elements
	 regardless of which of three encodings has been utilized.  
	 It begins by testing to see if there are any elements of this type
	 with content.-->
	<xsl:template name="associated-information">
		<xsl:if
			test="string(ead:archdesc/ead:prefercite/ead:*)
			or string(ead:archdesc/ead:otherfindaid/ead:*)
			or string(ead:archdesc/ead:bibliography/ead:*)
			or string(ead:archdesc/ead:fileplan/ead:*)
			or string(ead:archdesc/ead:originalsloc/ead:*)
			or string(ead:archdesc/ead:legalstatus/ead:*)
			or string(ead:archdesc/ead:odd/ead:*)
			or string(ead:archdesc/ead:index/ead:*)">

			<fo:block xsl:use-attribute-sets="h3" id="associatedlink">
				<xsl:text>Associated Information</xsl:text>
			</fo:block>
			<xsl:apply-templates select="ead:archdesc/ead:prefercite"/>
			<xsl:apply-templates select="ead:archdesc/ead:otherfindaid"/>
			<xsl:apply-templates select="ead:archdesc/ead:bibliography"/>
			<xsl:apply-templates select="ead:archdesc/ead:fileplan"/>
			<xsl:apply-templates select="ead:archdesc/ead:orignalsloc"/>
			<xsl:apply-templates select="ead:archdesc/ead:legalstatus"/>
			<xsl:apply-templates select="ead:archdesc/ead:odd"/>
			<xsl:apply-templates select="ead:archdesc/ead:index"/>
		</xsl:if>
	</xsl:template>


	<xsl:template
		match="ead:archdesc/ead:prefercite/ead:head
		|ead:archdesc/ead:otherfindaid/ead:head
		| ead:archdesc/ead:bibliography/ead:head
		| ead:archdesc/ead:fileplan/ead:head
		| ead:archdesc/ead:originalsloc/ead:head
		| ead:archdesc/ead:legalstatus/ead:head
		| ead:archdesc/ead:odd/ead:head
		| ead:archdesc/ead:index/ead:head">
		<fo:block margin-left="25pt" xsl:use-attribute-sets="h4" id="{generate-id()}">
			<fo:inline font-weight="bold">
				<xsl:apply-templates/>
			</fo:inline>
		</fo:block>
	</xsl:template>


	<xsl:template
		match="ead:archdesc/ead:prefercite/ead:p
		| ead:archdesc/ead:otherfindaid/ead:p
		| ead:archdesc/ead:bibliography/ead:p
		| ead:archdesc/ead:originalsloc/ead:p
		| ead:archdesc/ead:fileplan/ead:p
		| ead:archdesc/ead:odd/ead:p
		| ead:archdesc/ead:legalstatus/ead:p
		| ead:archdesc/ead:index/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent50" keep-with-next.within-page="always">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	
<!--   *****************************SECTION 12: FORMATS AN INDEX  ************************************************************ -->
	

<!-- **************** This section needs further testing. ***************** -->


	<!--This template rule tests for and formats the top-level index element. It begins
	by testing to see if there is an index element with content.-->
	<xsl:template match="ead:archdesc/ead:index
		| ead:archdesc/*/index">
		<fo:table width="100%">
			<fo:table-column column-number="5%"/>
			<fo:table-column column-width="45%"/>
			<fo:table-column column-width="50%"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell number-columns-spanned="3">
						<fo:block xsl:use-attribute-sets="h3">
							<fo:basic-link internal-destination="{generate-id(ead:head)}">
								<xsl:apply-templates select="ead:head"/>
							</fo:basic-link>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<xsl:for-each select="ead:p | ead:note/ead:p">
					<fo:table-row>
						<fo:table-cell/>
						<fo:table-cell number-columns-spanned="2">
							<fo:block>
								<xsl:apply-templates/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
				<!--Processes each index entry.-->
				<xsl:for-each select="ead:indexentry">
					<!--Sorts each entry term.-->
					<xsl:sort
						select="ead:corpname | ead:famname | ead:function | ead:genreform | ead:geogname | ead:name | ead:occupation | ead:persname | ead:subject"/>
					<fo:table-row>
						<fo:table-cell/>
						<fo:table-cell>
							<fo:block>
								<xsl:apply-templates
									select="ead:corpname | ead:famname | ead:function | ead:genreform | ead:geogname | ead:name | ead:occupation | ead:persname | ead:subject"
								/>
							</fo:block>
						</fo:table-cell>
						<!--Supplies whitespace and punctuation if there is a pointer
						group with multiple entries.-->
						<xsl:choose>
							<xsl:when test="ead:ptrgrp">
								<fo:table-cell>
									<fo:block>
										<xsl:for-each select="ead:ptrgrp">
											<xsl:for-each select="ead:ref | ead:ptr">
												<xsl:apply-templates/>
												<xsl:if test="preceding-sibling::ref or preceding-sibling::ptr">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</fo:block>
								</fo:table-cell>
							</xsl:when>
							<!--If there is no pointer group, process each reference or pointer.-->
							<xsl:otherwise>
								<fo:table-cell>
									<fo:block>
										<xsl:for-each select="ead:ref | ead:ptr">
											<xsl:apply-templates/>
										</xsl:for-each>
									</fo:block>
								</fo:table-cell>
							</xsl:otherwise>
						</xsl:choose>
					</fo:table-row>
					<!--Closes the indexentry.-->
				</xsl:for-each>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<!-- ***********************SECTION 13:  FORMATS DSC HEAD AND P .  **********************************************************	
		
	This section of the stylesheet contains separate templates for
each component level.  The contents of each is identical except for the
spacing that is inserted to create the proper column display for each level.-->

	<!--This section of the stylesheet formats ead:dsc, its ead:head, and
any introductory paragraphs. -->

	<xsl:template match="ead:dsc">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="ead:dsc/ead:head">
		<fo:block xsl:use-attribute-sets="h2" text-align="left" id="{generate-id()}">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="ead:dsc/ead:p">
		<fo:block xsl:use-attribute-sets="divIndent25" text-align="left">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
<!-- ***********************SECTION 14:  GENERICALLY FORMATS THE DID ELEMENTS FOR ALL COMPONENT LEVELS  **********************************************************	-->

	<!--This template formats the unitid, origination, unittitle, 
	unitdate, and physdesc elements of components at all levels.  They appear on
	a separate line from other ead:did elements. It is generic to all
	component levels.-->
	<xsl:template name="component-did">
		<!--Inserts unitid and a space if it exists in the markup.-->
		<xsl:if test="ead:unitid">
			<xsl:apply-templates select="ead:unitid"/>
			<xsl:text>&#x20;.</xsl:text>
		</xsl:if>

		<xsl:if test="ead:unittitle">
			<xsl:choose>
				<xsl:when test="ead:unittitle[following-sibling::ead:unitdate or following-sibling::ead:unitdatestructured]">
					<xsl:apply-templates select="ead:unittitle"/>
					<xsl:text>,&#x20;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="ead:unittitle"/>
					<xsl:text>.&#x20;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="ead:unitdate">
			<xsl:apply-templates select="ead:unitdate"/>
			<xsl:text>.&#x20;&#x20;</xsl:text>
		</xsl:if>

		<xsl:if test="ead:unitdatestructured/ead:daterange">
			<xsl:apply-templates select="ead:unitdatestructured/ead:daterange/ead:fromdate"/>
			<xsl:text>-</xsl:text>
			<xsl:apply-templates select="ead:unitdatestructured/ead:daterange/ead:todate"/>
			<xsl:text>.&#x20;&#x20;</xsl:text>
		</xsl:if>
		
		<xsl:if test="ead:unitdatestructured/ead:datesingle">
			<xsl:apply-templates select="ead:unitdatestructured/ead:datesingle"/>
			<xsl:text>.&#x20;&#x20;</xsl:text>
		</xsl:if>

		<xsl:if test="ead:physdesc">
			<xsl:apply-templates select="ead:physdesc"/>
			<xsl:text>.</xsl:text>
		</xsl:if>

		<xsl:if test="ead:physdescstructured">
			<xsl:apply-templates select="ead:quantity"/>
			<xsl:text>&#x20;</xsl:text>
			<xsl:apply-templates select="ead:carrier"/>
			<xsl:text>.</xsl:text>
		</xsl:if>

		<xsl:if test="ead:parallelphysdescset">
			<xsl:call-template name="parallel-physdesc"/>
		</xsl:if>
	</xsl:template>
	
	<!-- ***********************SECTION 15:  FORMATS EACH COMPONENT LEVEL OF DSC.  **********************************************************	-->	


<!-- ********** 15A.  FORMATS C01 ************************************************** -->	
	

<!-- Creates a table for each c01 -->

	<xsl:template match="ead:c01">
		<fo:table width="100%" table-layout="fixed">
			<fo:table-column column-width=".3in" number-columns-repeated="20"/>
			<fo:table-body>
				<xsl:apply-templates/>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<!--Processes the content of c01 which is assumed not to have associated containers.
	Adjustments in column widths are required if there are container elements in this <did>.	-->

	<xsl:template match="ead:c01/ead:did">
		<fo:table-row>
			<fo:table-cell number-columns-spanned="20" padding-bottom="5pt" padding-top="5pt">
				<fo:block vertical-align="top" xsl:use-attribute-sets="h3" space-after="12pt"
					id="{generate-id()}">
					<fo:inline font-weight="bold">
						<xsl:call-template name="component-did"/>
					</fo:inline>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
			<fo:table-row>
				<fo:table-cell>
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="19">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
	</xsl:template>

	<!--This template creates a separate row for each child of the listed elements.-->
	<xsl:template
		match="ead:c01/ead:scopecontent  | ead:c01/ead:bioghist | ead:c01/ead:arrangement
		| ead:c01/ead:userestrict | ead:c01/ead:accessrestrict | ead:c01/ead:processinfo |
		ead:c01/ead:acqinfo | ead:c01/ead:custodhist | ead:c01/ead:controlaccess/ead:controlaccess |
		ead:c01/ead:odd | ead:c01/ead:note">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell>
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="19">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c02"/>
	</xsl:template>
	
	<!-- ********** 15B.  FORMATS C02 ************************************************** -->		

	<!--This template assumes that c02 elements have associated containers, for
	example when ead:c02 is a file.  Adjustments will hve to be made to the columns
	if there are no associated container elements in this <did>.  -->

	<xsl:template match="ead:c02/ead:did">

		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
					or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
					@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
					or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
					or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
					or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
					@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
						not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="18">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"> </fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="18">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="4">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="16">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Processes the rest of the c02 elements. -->
	<xsl:template
		match="ead:c02/ead:scopecontent | ead:c02/ead:bioghist | ead:c02/ead:arrangement |
			ead:c02/ead:altformavail | ead:c02/ead:appraisal | ead:c02/ead:bibliography |
			ead:c02/ead:userestrict | ead:c02/ead:accessrestrict | ead:c02/ead:processinfo |
			ead:c02/ead:acqinfo | ead:c02/ead:custodhist | ead:c02/ead:controlaccess/ead:controlaccess |
			ead:c02/ead:odd | ead:c02/ead:note/ead:p | ead:c02/fileplan | ead:c02/ead:index |
			ead:c02/ead:originalsloc | ead:c02/ead:otherfindaid | ead:c02/ead:phystech |
			ead:c02/ead:prefercite | ead:c02/relatedmaterial | ead:c02/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="4">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="16">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c03"/>
		
<!-- ********** 15C.  FORMATS C03 ************************************************** -->	
		
	</xsl:template>
	<!--These next two templates processes c03 elements.-->
	<xsl:template match="ead:c03/ead:did">
		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
				@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
				or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
				or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
				@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
					not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="17">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="17">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="5">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="15">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template
		match="ead:c03/ead:scopecontent | ead:c03/ead:bioghist | ead:c03/ead:arrangement |
		ead:c03/ead:altformavail | ead:c03/ead:appraisal | ead:c03/ead:bibliography |
		ead:c03/ead:userestrict | ead:c03/ead:accessrestrict | ead:c03/ead:processinfo |
		ead:c03/ead:acqinfo | ead:c03/ead:custodhist | ead:c03/ead:controlaccess/ead:controlaccess |
		ead:c03/ead:odd | ead:c03/ead:note/ead:p | ead:c03/fileplan | ead:c03/ead:index |
		ead:c03/ead:originalsloc | ead:c03/ead:otherfindaid | ead:c03/ead:phystech |
		ead:c03/ead:prefercite | ead:c03/relatedmaterial | ead:c03/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="5">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="15">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c04"/>
		</xsl:template>

	<!-- ********** 15D.  FORMATS C04 ************************************************** -->	

	<!--These next two templates process c04 elements, first the <did> and then other elements.-->
	
	<xsl:template match="ead:c04/ead:did">
		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
				@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
				or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
				or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
				@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
					not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="2">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="16">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="2">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>

						<fo:table-cell number-columns-spanned="16">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="6">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="14">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template
		match="ead:c04/ead:scopecontent | ead:c04/ead:bioghist | ead:c04/ead:arrangement |
		ead:c04/ead:altformavail | ead:c04/ead:appraisal | ead:c04/ead:bibliography |
		ead:c04/ead:userestrict | ead:c04/ead:accessrestrict | ead:c04/ead:processinfo |
		ead:c04/ead:acqinfo | ead:c04/ead:custodhist | ead:c04/ead:controlaccess/ead:controlaccess |
		ead:c04/ead:odd | ead:c04/ead:note/ead:p | ead:c04/fileplan | ead:c04/ead:index |
		ead:c04/ead:originalsloc | ead:c04/ead:otherfindaid | ead:c04/ead:phystech |
		ead:c04/ead:prefercite | ead:c04/relatedmaterial | ead:c04/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="6">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="14">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c05"/>
	</xsl:template>

	<!-- ********** 15E.  FORMATS C05 ****************************************************************** -->	
	
	
	<!--These next two templates processes c05 elements, first the <did> and the remaining elements.-->
	<xsl:template match="ead:c05/ead:did">
		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
				@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
				or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
				or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
				@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
					not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="3">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="15">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"> </fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="3">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="15">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="7">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="13">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template
		match="ead:c05/ead:scopecontent | ead:c05/ead:bioghist | ead:c05/ead:arrangement |
		ead:c05/ead:altformavail | ead:c05/ead:appraisal | ead:c05/ead:bibliography |
		ead:c05/ead:userestrict | ead:c05/ead:accessrestrict | ead:c05/ead:processinfo |
		ead:c05/ead:acqinfo | ead:c05/ead:custodhist | ead:c05/ead:controlaccess/ead:controlaccess |
		ead:c05/ead:odd | ead:c05/ead:note/ead:p | ead:c05/fileplan | ead:c05/ead:index |
		ead:c05/ead:originalsloc | ead:c05/ead:otherfindaid | ead:c05/ead:phystech |
		ead:c05/ead:prefercite | ead:c05/relatedmaterial | ead:c05/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="7">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="13">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c06"/>			
	</xsl:template>
	
	<!-- ********** 15F.  FORMATS C06 *************************************************************** -->	

	<!--These next two templates processes c06 elements.-->
	<xsl:template match="ead:c06/ead:did">
		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
				@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
				or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
				or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
				@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
					not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="4">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="14">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"> </fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="4">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="14">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="8">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="12">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template
		match="ead:c06/ead:scopecontent | ead:c06/ead:bioghist | ead:c06/ead:arrangement |
		ead:c06/ead:altformavail | ead:c06/ead:appraisal | ead:c06/ead:bibliography |
		ead:c06/ead:userestrict | ead:c06/ead:accessrestrict | ead:c06/ead:processinfo |
		ead:c06/ead:acqinfo | ead:c06/ead:custodhist | ead:c06/ead:controlaccess/ead:controlaccess |
		ead:c06/ead:odd | ead:c06/ead:note/ead:p | ead:c06/fileplan | ead:c06/ead:index |
		ead:c06/ead:originalsloc | ead:c06/ead:otherfindaid | ead:c06/ead:phystech |
		ead:c06/ead:prefercite | ead:c06/relatedmaterial | ead:c06/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="8">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="12">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c07"/>		
	</xsl:template>
	
	<!-- ********** 15G.  FORMATS C07 *************************************************************************** -->	

	<!--These next two template processes c07 elements.-->
	<xsl:template match="ead:c07/ead:did">
		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
				@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
				or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
				or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
				@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
					not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="5">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="13">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"> </fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="5">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="13">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="9">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="11">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template
		match="ead:c07/ead:scopecontent | ead:c07/ead:bioghist | ead:c07/ead:arrangement |
		ead:c07/ead:altformavail | ead:c07/ead:appraisal | ead:c07/ead:bibliography |
		ead:c07/ead:userestrict | ead:c07/ead:accessrestrict | ead:c07/ead:processinfo |
		ead:c07/ead:acqinfo | ead:c07/ead:custodhist | ead:c07/ead:controlaccess/ead:controlaccess |
		ead:c07/ead:odd | ead:c07/ead:note/ead:p | ead:c07/fileplan | ead:c07/ead:index |
		ead:c07/ead:originalsloc | ead:c07/ead:otherfindaid | ead:c07/ead:phystech |
		ead:c07/ead:prefercite | ead:c07/relatedmaterial | ead:c07/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="9">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="11">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c08"/>
	</xsl:template>
	
	<!-- ********** 15H.  FORMATS C08 ************************************************************************************* -->		
	
	<!--These nex two templates processes c08 elements.-->
	<xsl:template match="ead:c08/ead:did">
		<xsl:for-each select="self::ead:did">
			<!--The next two variables define the set of container types that
		may appear in the first column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="first"
				select="ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or @localtype='Reel' or @localtype='reel' or 
				@localtype='box' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<!--This variable defines the set of container types that
		may appear in the second column of a two column container list.
		Add or subtract ead:container types to fix institutional practice.-->
			<xsl:variable name="second"
				select="ead:container[@localtype='Folder'
				or @tlocalype='Frame' or @localtype='Page'  or @localtype='Reel' or @localtype='folder'
				or @localtype='frame' or @localtype='page'  or @localtype='reel']"/>
			<xsl:variable name="preceding"
				select="preceding::ead:did[1]/ead:container[@localtype='Box'
				or @localtype='Oversize' or @localtype='Volume' or @localtype='Carton' or
				@localtype='box' or @localtype='Reel' or @localtype='reel' or @localtype='oversize' or @localtype='volume' or @localtype='carton']"/>
			<xsl:choose>
				<!--When the container value or the container type of the first
			 container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.-->
				<xsl:when
					test="$first and (not($preceding=$first) or
					not($preceding/@localtype=$first/@localtype))">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$first/@localtype"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="box-folder">
								<xsl:value-of select="$second/@localtype"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[1]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="6">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="12">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"> </fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="1">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component">
								<xsl:value-of select="ead:container[2]"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="6">
							<fo:block vertical-align="top" xsl:use-attribute-sets="component"/>
						</fo:table-cell>
						<fo:table-cell number-columns-spanned="12">
							<fo:block xsl:use-attribute-sets="component">
								<xsl:call-template name="component-did"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each
				select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec
				| ead:origination | ead:physloc">
				<fo:table-row>
					<fo:table-cell number-columns-spanned="10">
						<fo:block> </fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="10">
						<fo:block vertical-align="top" xsl:use-attribute-sets="component">
							<xsl:apply-templates/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template
		match="ead:c08/ead:scopecontent | ead:c08/ead:bioghist | ead:c08/ead:arrangement |
		ead:c08/ead:altformavail | ead:c08/ead:appraisal | ead:c08/ead:bibliography |
		ead:c08/ead:userestrict | ead:c08/ead:accessrestrict | ead:c08/ead:processinfo |
		ead:c08/ead:acqinfo | ead:c08/ead:custodhist | ead:c08/ead:controlaccess/ead:controlaccess |
		ead:c08/ead:odd | ead:c08/ead:note/ead:p | ead:c08/fileplan | ead:c08/ead:index |
		ead:c08/ead:originalsloc | ead:c08/ead:otherfindaid | ead:c08/ead:phystech |
		ead:c08/ead:prefercite | ead:c08/relatedmaterial | ead:c08/separatedmaterial">
		<xsl:for-each select="*[not(self::ead:head)]">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="10">
					<fo:block> </fo:block>
				</fo:table-cell>
				<fo:table-cell number-columns-spanned="10">
					<fo:block vertical-align="top" xsl:use-attribute-sets="component">
						<xsl:apply-templates/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
