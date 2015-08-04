<!-- XSLT stylesheet for EAD3 to HTML transformation.  Version: BETA 0.7.2  Date: August 4, 2015   Author: Michael J. Fox-->


<!--Prologue:   Things you should know about this stylesheet.
	1.  This is a beta version.  It will benefit from additional testing against various EAD3 instances.  The author offers no guarantees but 
			will certainly attempt to fix that which is not functioning properly.
	2.  It is offered freely to the community but if you makes changes, take credit for them. 
	3.  Bugs, suggestions, and all manner of comments should be directed to the author at foxmjc@gmail.com.
	4.  Because this styesheet is intended to be a pedagogical instrument as well as a practical tool, much of the HTML styling 
			is repeated throughout the document rather than being compacted through the use of the style element in the the html/head or in a separate 
			CSS stylesheet.  
	4.  This stylesheet was created and tested using Oxygen v. 17.1 and Saxon v. 6.5.5 packaged with that verison of Oxygen.
			The XSLT and XPath syntax is that of version 1.0 but should be compatible with version 2.0 of both standards.
	6.  Given the range of practice that EAD3 accommodates, it is difficult to imagine all the variations that users might employ in markup. 
			If the options incorporated in this sytlesheet "break" from your encoding, I'd love to hear from you with examples of the problems.
	7.  Not all of the new elements and attributes in EAD3 are fully supported at this time.  As examples of their use in the community are 
			created and shared, and "best practices" are promulgated, the author will attempt to fill in these lacunae.  This includes but is not 
			limited to the "experimental" relations element and the use of certain attributes within the children of controlaccess
			(persname, corpname, subject, geogname, etc.) intended to facilitate linked data.
	8.  <unitdatestructured> and <physdescstructured> with their complex structure and numerous options also fall into the category of 
			"show-me-your-markup-and-I'll-try-to-accommdate-it."   At this stage, the author can only imagine how users will apply the markup 
			options for thes new elements.  There are extensive comments regarding <physdescstructured> in sections 2e and 4e. 
	9.  An attempt has been made to supply standard, library type punctuation within the text of elements that serve as "access points" and 
			make use of the part child of controlaccess children, e.g.  United States. Army. 101st Airborne Division-History-World War, 
			1939-1945-Personal narratives, American.
	10. Extensive and hopefully explanatory comments are included adjacent to various templates.  If the syntax of a given template is unclear, 
			please let me know. Hopefully I will be able to clear up your questions and make my comments in the stylesheet more expansive and clearer.
	11.	The XSLT syntax coverning the display of container values and columns heads in the <dsc> has been changed.   The default approach in this stylesheet
			uses the position of the container elements (first container or second container) to determine what is displayed rather than the value of the 
			type (now localtype) attribute.   The code previously used is appended as a comment at the end of this styesheet and can be substituted for 
			by inserting it at every component level and removing the existing code.
	12. As with stylesheets for the first two versions of EAD, four sets of elements are grouped together in the table of contents and in the
			body of the finding aid: access and use restrictions; separated and related materials; five elements containing administrative information; 
			and seven elements that contain information associated with the materials being described but which do not describe them per se.  
			These can easily be changed so that they appear at the same level of presentation in the table of contents and the body of the finding aid 
			as the major descriptive elements: scope and content, administrative history or biography, and arrangement.
	13. Above all, I'd love to hear from you about the good, as well as the bad and downright ugly.
-->
 

<!-- *************************  TABLE OF CONTENTS FOR THE STYLESHEET ***********************************-->

<!-- This stylesheet has three principal areas: the first (section 1) defines the high-level HTML output that results from this transformation;
			the second (sections 3-11) is a set of templats that apply to individual or groups of elements that are the children of control and archdesc; 
			the last part (sections 12 and 13) contains a series of generic and named templates that are invoked throughout the stylesheet..-->

<!--
Section 1:  Generates the HTML output resulting from this transformation
     1a.      Creates the content of html/head  
     1b.			Creates the content of html/body	
     1c.      Inserts a logo at the top of the document and creates two columns within the HTML file
							 (one for the table of contents and one for the body of the finding aid)and forms a brief "title page."
   	
Section 2: Formats <control>

Section 3 Formats <archdesc>/<did>
		3a:				Creates a table for <did> and sequences the <did> children
		3b:				Formats <repository> and <origination> 
		3c: 			Formats <unitid>, <unititle>, <unidate>, <physdesc>
							<abstract>, <physloc>, and <materialspec>
		3d:				Formats <unitdatestructured>
		3e:				Formats <physdescstructured>
		3f:				Formats <langmaterial>
		3g:				Formats <didnote>
		3h:				Formats <dao> and <daoset>
		
Section 4:		Formats the remaining primary chlidren of <archdesc>
		4a:				Formats non-recursive <bioghist> and <scopecontent>, as well as 
							<phystech>,<arrangement>, <altformavail>
		4b:				Formats recursive <bioghist> and <scopecontent>
		4c:				Formats <list> within <arrangement>	
		
Section 5:	Formats <controlaccess>
		5a:				Formats <head> and <p>
		5b:				Formats non-recursive <controlaccess>
		5c:				Formats recursive <controlaccess>				
		
Section 6:	Formats <relatedmaterial> and <separatedmaterial>

Section 7:	Formats <accessrestrict> and <userestrict>

Section 8:	Formats administrative information:
							<custodhist>, <acqinfo>, <processinfo>, <appraisal>, and <accruals>
							
Section 9:	Formats associated information:
							<prefercite>, <otherfindaid>, <fileplan>,	<originalsloc>, <legalstatus>, <odd>, <bibliography>, and <index>???????????????????????
							
Section 10:	Formats <index>

Section 11:	Formats dsc
		11a:   	<dsc>/<head> and <dsc>/<p>
		11b:		Generates an HTML table for components and calls the individual templates for each component level

Section 12: Formats individual component levels
		12a:		Formats <c01>
		12b:		Formats <c02>
		12c:		Formats <c03>
		12d:		Formats <c04>
		12e:		Formats <c05>
		12f:		Formats <c06>
		12g:		Formats <c07>
		12h:		Formats <c08>
		12i:		Formats <c09>
		12j:		Formats <c10>

Section 13: Generic and named templates
		13a.		Generates META tags that are added to html/head
		13b.		Generates a table of contents for archdesc and its chidren
		13c:		Specifies the sequence of display for <archdesc> and its children
		13d:		Formats and punctuates elements that have <part> children
		13e:		Formats <physdescstructured>
		13f:		Formats <dao> generically
		13g:		Formats @render in <emph> and <title>
		13h:		Formats <ref> generically
		13i:		Formats <list> generically
		13j:		Formats <table> generically
		13k:		Formats <chronlist> generically
		13l:		Formats <unitid>, <unittitle>, <unitdate>, <unitdatestructured>  
							<physdesc>, <physdescstructured>, and <physdescset>	for all component level
		13m:		Formats unitdatestructured					
		13n:		Formats the display of containers 

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:ead="http://ead3.archivists.org/schema/" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:strip-space elements="*"/>
	<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"
		doctype-public="-//W3C//DTD HTML 4.0 Transitional//EN"/>
	<!--************ Section 1:  Generates the base HTML document that is the result of this transformation.-->
	<!--************ Secton 1a:  Populates the head element of the HTML output.-->
	<xsl:template match="ead:ead">
		<html>
			<head>
				<style type="text/css">
					h1,
					h2,
					h3,
					h4{
						font-family:arial
					}
					td
					{
						vertical-align:top
					}</style>
				<xsl:call-template name="metadata"/>
			</head>

			<!-- ********Section 1b:  Populates the body element of the HTML outpt.*************** -->
			<body>
				<!-- Creates a pseudo "title page" by inserting a logo and specified data from the control area.-->
				<!--Insert the proper path to your image in place of yourlogo.gif. 
						If you do not want to include an image, delete the center element and its contents.-->
				<center>
					<img src="cchslogo.gif"/>
				</center>
				<xsl:apply-templates select="ead:control"/>
				<hr/>
				<!-- ***Section 1c: Creates a two column table with the table of content in the left column and
				the body of the finding aid in the right one.-->
				<table width="100%">
					<tr>
						<!-- The table of contents goes in the left column .  -->
						<td valign="top" bgcolor="#E0E0E0" width="20%">
							<xsl:call-template name="toc"/>
						</td>
						<!--The body of the finding aid goes in the right column.  -->
						<td valign="top" bgcolor="#FAFDD5" width="80%">
							<xsl:call-template name="findaid"/>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>

	<!-- ***********Section 2:  Formats the control element*************************************-->
	<!-- Displays certain control elements and suppreses all others.-->
	<xsl:template match="ead:control">
		<h2 style="text-align:center">
			<xsl:value-of select="ead:filedesc/ead:titlestmt/ead:titleproper"/>
		</h2>
		<h3 style="text-align:center">
			<xsl:value-of select="ead:filedesc/ead:titlestmt/ead:subtitle"/>
		</h3>
		<br/>
	</xsl:template>

	<!-- *******************THIS BEGINS THE FORMATTING OF THE CHILDREN OF ARCHDESC******************************* -->

	<!-- **********Section 3: Formats the child elements of archdesc/did.-->

	<!--********** Section 3a.  Creates a table for the did and specifies the sequence and format of its children. *********************-->

	<!-- 	This template transforms archdesc/did/head, creates a table, and inserts each of the did children.  Physdescstructured is
		processed the same way whether it is a child of did or of physdescset. -->
	<xsl:template match="ead:archdesc/ead:did">
		<h3>
			<a name="{generate-id(ead:head)}">
				<xsl:apply-templates select="ead:head"/>
			</a>
		</h3>
		<table width="100%">
			<tr>
				<td width="25%"> </td>
				<td width="75%"> </td>
			</tr>
			<!--One can change the order of appearance for the children of ead:did by changing the order of the following statements.-->
			<tr>
				<td coldiv="2">
					<xsl:apply-templates select="ead:repository"/>
					<xsl:apply-templates select="ead:origination"/>
					<xsl:apply-templates select="ead:unittitle"/>
					<xsl:apply-templates select="ead:unitdate"/>
					<xsl:apply-templates select="ead:unitdatestructured"/>
					<xsl:apply-templates select="ead:physdesc"/>
					<xsl:apply-templates select="//ead:physdescstructured"/>
					<xsl:apply-templates select="ead:abstract"/>
					<xsl:apply-templates select="ead:unitid"/>
					<xsl:apply-templates select="ead:physloc"/>
					<xsl:apply-templates select="ead:langmaterial"/>
					<xsl:apply-templates select="ead:materialspec"/>
					<xsl:apply-templates select="ead:didnote"/>
					<xsl:apply-templates select="ead:dao"/>
					<xsl:apply-templates select="ead:daoset/ead:dao"/>
				</td>
			</tr>
		</table>
		<hr/>
	</xsl:template>

	<!--********** Section 3b.  Formats repository and origination. ****************************************************** -->
	<!-- *********These elements are prcessed separately because their descendant <part> is unique among the <did> children.
	This template applies templates in section 12d.-->
	<xsl:template
		match="
			ead:archdesc/ead:did/ead:repository/ead:corpname
			| ead:archdesc/ead:did/ead:origination/ead:corpname
			| ead:archdesc/ead:did/ead:origination/ead:persname
			| ead:archdesc/ead:did/ead:origination/ead:famname">
		<!--The portion of the template tests to see if there is a label attribute,
		inserting its contents if there is or adding display text if there isn't.
		The content of the supplied label depends on the element.  To change the
		supplied label, simply alter the template below.-->
		<xsl:choose>
			<xsl:when test="parent::ead:*[@label]">
				<tr>
					<td valign="top">
						<b>
							<xsl:value-of select="parent::ead:*/@label"/>
						</b>
					</td>
					<td valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td valign="top">
						<xsl:choose>
							<xsl:when test="parent::ead:repository">
								<b>
									<xsl:text>Repository: </xsl:text>
								</b>
							</xsl:when>
							<xsl:when test="parent::ead:origination">
								<xsl:text>Creator: </xsl:text>
							</xsl:when>
						</xsl:choose>
					</td>
					<td valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********** Section 3c.  Formats unititle, unitdate, physdesc, abstract, unitid, physloc and materialspec  *****************  -->
	<!-- These elements share a common presentation in this stylesheet.  The remaining  <did> children have varying content models and 
		are handled by separate, element-specific templates that follow.-->
	<xsl:template
		match="
			ead:archdesc/ead:did/ead:unittitle
			| ead:archdesc/ead:did/ead:unitdate
			| ead:archdesc/ead:did/ead:physdesc
			| ead:archdesc/ead:did/ead:unitid
			| ead:archdesc/ead:did/ead:physloc
			| ead:archdesc/ead:did/ead:abstract
			| ead:archdesc/ead:did/ead:materialspec">

		<!--This portion of the template tests to see if there is a label attribute,
		inserting its contents if there is or adding text supplied by the stylesheet if there isn't.
		The content of the supplied label depends on the element. Change the values of the 
		supplied labels s you wish.   -->
		<!--If there is a label attribute, insert it in the first column and the text of the 
	  	element in the second column.. -->
		<xsl:choose>
			<xsl:when test="@label">
				<tr>
					<td valign="top">
						<b>
							<xsl:value-of select="@label"/>
						</b>
					</td>
					<td>
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:when>
			<!--	If there is no label attribute, supply a label for the first column and
					insert the text of the element in the second column. -->
			<xsl:otherwise>
				<tr>
					<td valign="top">
						<b>
							<xsl:choose>
								<xsl:when test="self::ead:unittitle">
									<xsl:text>Title:</xsl:text>
								</xsl:when>
								<xsl:when test="self::ead:unitdate">
									<xsl:text>Dates:</xsl:text>
								</xsl:when>
								<xsl:when test="self::ead:physdesc">
									<xsl:text>Quantity: </xsl:text>
								</xsl:when>
								<xsl:when test="self::ead:physloc">
									<xsl:text>Location: </xsl:text>
								</xsl:when>
								<xsl:when test="self::ead:unitid">
									<xsl:text>Identification: </xsl:text>
								</xsl:when>
								<xsl:when test="self::ead:abstract">
									<xsl:text>Abstract: </xsl:text>
								</xsl:when>
								<xsl:when test="self::ead:materialspec">
									<xsl:text>Technical Information: </xsl:text>
								</xsl:when>
							</xsl:choose>
						</b>
					</td>
					<td>
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ******** Section 3d.  Formats unitdatestructured   ******************************************************** -->
	<xsl:template match="ead:archdesc/ead:did/ead:unitdatestructured">
		<xsl:choose>
			<xsl:when test="@label">
				<tr>
					<td>
						<b>
							<xsl:value-of select="@label"/>
						</b>
					</td>
					<td>
						<xsl:call-template name="unitdatedstructured-common"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<b>
							<xsl:text>Dates:</xsl:text>
						</b>
					</td>
					<td>
						<xsl:call-template name="unitdatedstructured-common"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<!--*********Section 3e:  Formats physdescstructured . ********************************************************************* -->
	<!-- Inserts phydescstructured elements into the table for archdesc/did and calls the concat-physdescstructured template.
	Only the first physdescstructured element is processed in this template.  If there are successive physdescstructured elements, 
	they are processed by the concat-physdescstructured named template in section 12e.-->
	<xsl:template match="ead:archdesc/ead:did//ead:physdescstructured[1]">
		<xsl:choose>
			<xsl:when test="@label">
				<tr>
					<td>
						<b>
							<xsl:value-of select="@label"/>
						</b>
					</td>
					<td>
						<xsl:call-template name="concat-physdescstructured"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<b>
							<xsl:text>Quantity: </xsl:text>
						</b>
					</td>
					<td>
						<xsl:call-template name="concat-physdescstructured"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--   This template suppresses subsequent physdescstructure elements which would be duplicative 
					having been processed by the preceeding template-->
	<xsl:template match="ead:archdesc/ead:did//ead:physdescstructured[position() > 1]"/>

	<!-- ********** Section 3f.  Formats langmaterial  ************************************************************   -->
	<xsl:template match="ead:archdesc/ead:did/ead:langmaterial">
		<xsl:for-each select="ead:language">
			<xsl:choose>
				<xsl:when test="parent::ead:langmaterial[@label]">
					<tr>
						<td>
							<b>
								<xsl:value-of select="parent::ead:langmaterial/@label"/>
							</b>
						</td>
						<td>
							<xsl:apply-templates/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td>
							<b>
								<xsl:text>Language: </xsl:text>
							</b>
						</td>
						<td>
							<xsl:apply-templates/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:if test="ead:descriptivenote">
			<tr>
				<td/>
				<td>
					<xsl:apply-templates select="ead:descriptivenote/ead:p"/>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>


	<!-- ********** Section 3g:  Formats didnote ***************************************************************   -->
	<xsl:template match="ead:archdesc/ead:did/ead:didnote">
		<xsl:for-each select="ead:didnote">
			<!--The template tests to see if there is a label attribute, inserting the contents if there is or adding one if there isn't. -->
			<xsl:choose>
				<xsl:when test="parent::ead:didnote[@label]">
					<!--This nested choose element tests for and processes the content of the first paragraph. Additional paragraphs do not get a separate label.-->
					<xsl:choose>
						<xsl:when test="self::ead:didnote[position() = 1]">
							<tr>
								<td>
									<b>
										<xsl:value-of select="parent::ead:didnote/@label"/>
									</b>
								</td>
								<td>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td/>
								<td>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!--Processes situations where there is no label attribute by supplying default text.-->
				<xsl:otherwise>
					<!--This nested choose tests for and processes the first paragraph. Additional paragraphs do not get a label.-->
					<xsl:choose>
						<xsl:when test="position() = 1">
							<tr>
								<td>
									<b>
										<xsl:text>Note: </xsl:text>
									</b>
								</td>
								<td>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td/>
								<td>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<!--Closes each <didnote>-->
		</xsl:for-each>
	</xsl:template>

	<!-- ********Section 3h:   Formats archdesc/did/dao and archdesc/did/daoset/dao -->

	<xsl:template match="ead:archdesc/ead:did/ead:dao">
		<xsl:for-each select="self::ead:dao">
			<tr>
				<td/>
				<td>
					<xsl:call-template name="dao-generic"/>
				</td>
			</tr>
			<tr>
				<td/>
				<td>
					<xsl:apply-templates select="ead:descriptivenote/ead:p"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="ead:archdesc/ead:did/ead:daoset/ead:dao">
		<xsl:for-each select="self::ead:dao">
			<tr>
				<td/>
				<td>
					<xsl:call-template name="dao-generic"/>
				</td>
			</tr>
			<tr>
				<td/>
				<td>
					<xsl:apply-templates select="ead:descriptivenote/ead:p"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>


	<!--************Section 4: Formats the remaining primary children of archdesc..  **************************************************************-->
	<!-- ********** Section 4a  Formats non-recursive bioghist and scopecontent, as well as phystech, arrangement and altformavail
			as well as chronlist inside bioghist and scopecontent.  **********  -->
	<xsl:template
		match="
			ead:archdesc/ead:bioghist |
			ead:archdesc/ead:scopecontent |
			ead:archdesc/ead:phystech |
			ead:archdesc/ead:arrangement |
			ead:archdesc/ead:altformavail">
		<xsl:apply-templates/>
	</xsl:template>
	<!--This template formats various head elements and makes them targets for
		links from the Table of Contents.-->
	<xsl:template
		match="
			ead:archdesc/ead:bioghist/ead:head |
			ead:archdesc/ead:scopecontent/ead:head |
			ead:archdesc/ead:phystech/ead:head |
			ead:archdesc/ead:arrangement/ead:head |
			ead:archdesc/ead:altformavail/ead:head">
		<h3 id="{generate-id()}">
			<xsl:apply-templates/>
		</h3>
	</xsl:template>
	<xsl:template
		match="
			ead:archdesc/ead:bioghist/ead:p |
			ead:archdesc/ead:scopecontent/ead:p |
			ead:archdesc/ead:phystech/ead:p |
			ead:archdesc/ead:arrangement/ead:p |
			ead:archdesc/ead:altformavail/ead:p">
		<p style="margin-left:25pt">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="
			ead:archdesc/ead:bioghist/ead:chronlist |
			ead:archdesc/ead:scopecontent/ead:chronlist">
		<div style="margin-left:25pt">
			<xsl:call-template name="chronlist-generic"/>
		</div>
	</xsl:template>

	<!-- ********** Section 4b.  Formats recursive bioghist and scopecontent elements as well as chronlist children of these
		elements when used recursivly.********************************************* -->
	<xsl:template
		match="ead:archdesc/ead:bioghist/ead:bioghist/ead:head | ead:archdesc/ead:scopecontent/ead:scopecontent/ead:head">
		<h4 id="{generate-id()}" margin-left="25pt">
			<xsl:apply-templates/>
		</h4>
	</xsl:template>
	<xsl:template
		match="
			ead:archdesc/ead:bioghist/ead:bioghist/ead:p |
			ead:archdesc/ead:scopecontent/ead:scopecontent/ead:p">
		<p style="margin-left:50pt">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="
			ead:archdesc/ead:bioghist/ead:bioghist/ead:chronlist |
			ead:archdesc/ead:scopecontent/ead:scopecontent/ead:chronlist">
		<div style="margin-left:50pt">
			<xsl:call-template name="chronlist-generic"/>
		</div>
	</xsl:template>

	<!--********** Section 4c.  Formats list within arrangement.  ******************************************************** -->
	<xsl:template match="ead:archdesc/ead:arrangement/ead:list/ead:head">
		<h3 style="margin-left:25pt" id="{generate-id()}">
			<xsl:apply-templates/>
		</h3>
	</xsl:template>
	<xsl:template match="ead:archdesc/ead:arrangement/ead:list/ead:item">
		<div style="margin-left:50pt">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!--   *****************************Section 5: Controlaccess ************************************************************ -->

	<!-- ********** 5a.  Formats controlaccess/head and controlaccess/p. ******************************* -->

	<!--******** This template formats the top-level controlaccess element.	It invokes either the template in 
		section 5b or section 5c depending on whether controlaccess is used recursively or not.  The templates are diferentiated by the 
		of the @mode attribute. -->
	<xsl:template match="ead:archdesc/ead:controlaccess">
		<h3 id="{generate-id(ead:head)}">
			<xsl:apply-templates select="ead:head"/>
		</h3>
		<p style="margin-left:25pt">
			<xsl:apply-templates select="ead:p"/>
		</p>
		<!-- Calls one of two named templates depending on whether controlaccess is used recursively or not. -->
		<xsl:choose>
			<!--Apply this template when there are recursive controlaccess elements.-->
			<xsl:when test="ead:controlaccess">
				<xsl:apply-templates mode="recursive" select="."/>
			</xsl:when>
			<!--Apply this template when the controlled terms are direct children of the controlaccess element.-->
			<xsl:otherwise>
				<xsl:apply-templates mode="direct" select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- **********Section 5b.  Formats non-recursive controlaccess child elements ************************************************ -->
	<!--This template formats controlled terms that are entered directly under the controlaccess element.  Elements are alphabetized.-->
	<xsl:template mode="direct" match="ead:archdesc/ead:controlaccess">
		<xsl:for-each
			select="ead:subject | ead:corpname | ead:famname | ead:persname | ead:genreform | ead:title | ead:geogname | ead:occupation">
			<xsl:sort select="." data-type="text" order="ascending"/>
			<div style="margin-left:20pt">
				<xsl:apply-templates/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<!-- **********Section 5c.  Formats recursive controlaccess child elements ***************************************************** -->
	<xsl:template mode="recursive" match="ead:archdesc/ead:controlaccess">
		<xsl:apply-templates select="ead:controlaccess"/>
	</xsl:template>

	<!--This template formats controlled terms that are nested within recursive controlaccess elements.   Terms are alphabetized within each grouping.-->
	<xsl:template match="ead:archdesc/ead:controlaccess/ead:controlaccess">
		<h4 style="margin-left:25pt">
			<xsl:apply-templates select="ead:head"/>
		</h4>
		<xsl:for-each
			select="ead:subject | ead:corpname | ead:famname | ead:persname | ead:genreform | ead:title | ead:geogname | ead:occupation">
			<xsl:sort select="." data-type="text" order="ascending"/>
			<div style="margin-left:50pt">
				<xsl:apply-templates/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<!--   *****************************Section 6: Formats the relatedmaterial and separated material elements   ************************************************************ -->
	<!--*************This template formats the top-level related and separated material elements,combining them under a single heading. It begins by testing to 
		see if there related or separated materials elements with content.-->
	<xsl:template name="archdesc-relatedmaterial">
		<xsl:if
			test="
				string(ead:archdesc/ead:relatedmaterial) or
				string(ead:archdesc/ead:separatedmaterial)">
			<h3 id="relatedmatlink">
				<xsl:text>Related Material</xsl:text>
			</h3>
			<xsl:for-each
				select="
					ead:archdesc/ead:relatedmaterial/ead:p |
					ead:archdesc/ead:separatedmaterial/ead:p">
				<div style="margin-left:25pt">
					<xsl:apply-templates/>
				</div>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!--   *****************************Section 7 Formats the accessrestrict and userestrict elements   ************************************************************ -->
	<!--This template rule formats a top-level access and use retriction elements. 	They are displayed under a common heading. 
		It begins by testing to see if there are any restriction elements with content.-->
	<xsl:template name="archdesc-restrict">
		<xsl:if
			test="
				string(ead:archdesc/ead:userestrict/*)
				or string(ead:archdesc/ead:accessrestrict/*)">
			<h3 id="restrictlink">
				<xsl:text>Restrictions</xsl:text>
			</h3>
			<p style="margin-left:25pt">
				<xsl:apply-templates select="ead:archdesc/ead:accessrestrict/ead:p"/>
			</p>
			<p style="margin-left:25pt">
				<xsl:apply-templates select="ead:archdesc/ead:userestrict/ead:p"/>
			</p>
		</xsl:if>
	</xsl:template>

	<!--   *****************************Section 8: Formats a set of elements of an administrative nature ************************************************************ -->
	<!--This templates consolidates all the other administrative information elements into one block under a common heading. It begins by testing
		to see if there are any elements of this type with content.-->
	<xsl:template name="archdesc-admininfo">
		<xsl:if
			test="
				string(ead:archdesc/ead:custodhist/*)
				or string(ead:archdesc/ead:acqinfo/*)
				or string(ead:archdesc/ead:processinfo/*)
				or string(ead:archdesc/ead:appraisal/*)
				or string(ead:archdesc/ead:accruals/*)">
			<h3 id="adminlink">
				<xsl:text>Administrative Information</xsl:text>
			</h3>
			<xsl:for-each
				select="
					ead:archdesc/ead:custodhist |
					ead:archdesc/ead:acqinfo |
					ead:archdesc/ead:processinfo |
					ead:archdesc/ead:appraisal |
					ead:archdesc/ead:accruals">
				<h4 style="margin-left:25pt" id="{generate-id()}">
					<xsl:apply-templates select="ead:head"/>
				</h4>
				<p style="margin-left:50pt">
					<xsl:apply-templates select="ead:p"/>
				</p>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!--   *****************************Section 9: Formats a set of eight elements that contain information related to but not directly about the materials described. ******************************************** -->
	<!--This templates consolidates information associated with the materials being described into a single block under a common heading.  It formats these elements
	 regardless of which of three encodings has been utilized.  It begins by testing to see if there are any elements of this type with content.-->
	<xsl:template name="associated-information">
		<xsl:if
			test="
				string(ead:archdesc/ead:prefercite/ead:*)
				or string(ead:archdesc/ead:otherfindaid/ead:*)
				or string(ead:archdesc/ead:bibliography/ead:*)
				or string(ead:archdesc/ead:fileplan/ead:*)
				or string(ead:archdesc/ead:originalsloc/ead:*)
				or string(ead:archdesc/ead:legalstatus/ead:*)
				or string(ead:archdesc/ead:odd/ead:*)
				or string(ead:archdesc/ead:index/ead:*)">
			<h3 id="associatedlink">
				<xsl:text>Associated Information</xsl:text>
			</h3>
			<xsl:for-each
				select="
					ead:archdesc/ead:prefercite
					| ead:archdesc/ead:otherfindaid
					| ead:archdesc/ead:bibliography
					| ead:archdesc/ead:fileplan
					| ead:archdesc/ead:originalsloc
					| ead:archdesc/ead:legalstatus
					| ead:archdesc/ead:odd
					| ead:archdesc/ead:index">
				<h4 style="margin-left:25pt" id="{generate-id()}">
					<xsl:apply-templates select="ead:head"/>
				</h4>
				<div style="margin-left:50pt">
					<xsl:apply-templates select="ead:p"/>
				</div>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!--   *****************************Section 10: Formats and index to the collection.  ************************************************************ -->
	<!-- **************** This section needs further testing. ***************** -->
	<!--This template rule tests for and formats the top-level index element. It begins by testing to see if there is an index element with content.-->
	<xsl:template match="ead:archdesc/ead:index | ead:archdesc/*/ead:index">
		<table width="100%">
			<tr>
				<td width="5%"/>
				<td width="45%"/>
				<td width="50%"/>
			</tr>
			<tr>
				<td number-columns-divned="3">
					<h3 id="{generate-id(ead:head)}">
						<xsl:apply-templates select="ead:head"/>
					</h3>
				</td>
			</tr>
			<xsl:for-each select="ead:p | ead:note/ead:p">
				<tr>
					<td/>
					<td number-columns-divned="2">
						<div>
							<xsl:apply-templates/>
						</div>
					</td>
				</tr>
			</xsl:for-each>

			<!--Processes each index entry.-->
			<xsl:for-each select="ead:indexentry">
				<!--Sorts each entry term.-->
				<xsl:sort
					select="ead:corpname | ead:famname | ead:function | ead:genreform | ead:geogname | ead:name | ead:occupation | ead:persname | ead:subject"/>
				<tr>
					<td/>
					<td>
						<div>
							<xsl:apply-templates
								select="ead:corpname | ead:famname | ead:function | ead:genreform | ead:geogname | ead:name | ead:occupation | ead:persname | ead:subject"
							/>
						</div>
					</td>
					<!--Supplies whitespace and punctuation if there is a pointer
						group with multiple entries.-->
					<xsl:choose>
						<xsl:when test="ead:ptrgrp">
							<td>
								<div>
									<xsl:for-each select="ead:ptrgrp">
										<xsl:for-each select="ead:ref | ead:ptr">
											<xsl:apply-templates/>
											<xsl:if
												test="preceding-sibling::ref or preceding-sibling::ptr">
												<xsl:text>, </xsl:text>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</div>
							</td>
						</xsl:when>
						<!--If there is no pointer group, process each reference or pointer.-->
						<xsl:otherwise>
							<td>
								<div>
									<xsl:for-each select="ead:ref | ead:ptr">
										<xsl:apply-templates/>
									</xsl:for-each>
								</div>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
				<!--Closes the indexentry.-->
			</xsl:for-each>
		</table>
	</xsl:template>

	<!-- ***********************Section 11:  Formats the desscription of subordinate components																	 -->

	<!-- ***********************Section 11a:  Formats the dsc head and paragraph   **********************************************************	-->
	<xsl:template match="ead:dsc">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="ead:dsc/ead:head">
		<h2 stye="text-align:left" id="{generate-id()}">
			<xsl:apply-templates/>
		</h2>
	</xsl:template>
	<xsl:template match="ead:dsc/ead:p">
		<div style="margin-left:25pt" text-align="left">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!--	The following section of the stylesheet contains a separate template for each component level c01 through level c10.  The contents of each is identical 
				except for the spacing that is inserted to create the proper columnar display for that level.-->
	<!-- 	Each component level in turn calls one or two named templates to process its container elements, then calls another template to process its children 
				other than did, and then applies the applicable templates for the next lower component level. -->

	<!-- ***********************Section 12a:  Transforms c01.  **********************************************************	-->

	<!--This template creates an HTML table for each c01 and its component children.-->
	<xsl:template match="ead:c01">
		<table style="width:600px; table-layout:fixed">
			<tr>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
			</tr>
			<xsl:for-each select="ead:did">
				<!-- ********  Test to determine whether this did element has a container child or not -->
				<xsl:choose>
					<!--      If there is a container child....   ********************* -->
					<xsl:when test="ead:container">
						<!-- Insert column heads based on the value of the localtype attribute, followed
						-->
						<tr style="font-weight:bold">
							<td>
								<xsl:apply-templates select="ead:container[1]/@ead:localtype"/>
							</td>
							<td style="font-weight:bold">
								<xsl:apply-templates select="ead:container[2]/@ead:localtype"/>
							</td>
						</tr>
						<!--    Insert the values of each of the container elements  -->
						<tr>
							<td>
								<xsl:apply-templates select="ead:container[1]"/>
							</td>
							<td>
								<xsl:apply-templates select="ead:container[2]"/>
							</td>
							<td colspan="18" valign="top" style="font-weight:bold">
								<!-- Generates a name attribute with the value "series" and its number to serve as 
										the target for internal hyperlinks. -->
								<a>
									<xsl:attribute name="name">
										<xsl:text>series</xsl:text>
										<xsl:number from="ead:dsc" count="ead:c01"/>
									</xsl:attribute>
								</a>
								<xsl:call-template name="component-did"/>
							</td>
						</tr>
						<xsl:for-each
							select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
							<tr>
								<td colspan="3"> </td>
								<td colspan="17" valign="top">
									<xsl:if test="./@ead:label">
										<xsl:apply-templates select="@ead:label"/>
										<xsl:text>: </xsl:text>
									</xsl:if>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:when>
					<!-- ********  If there is no container child...******************* -->
					<xsl:otherwise>
						<tr>
							<td colspan="20" valign="top" style="font-weight:bold">
								<!-- Generates a name attribute with the value "series" and its number in the sequence 
									of c01 elements to serve as the target for internal hyperlinks. -->
								<a>
									<xsl:attribute name="name">
										<xsl:text>series</xsl:text>
										<xsl:number from="ead:dsc" count="ead:c01"/>
									</xsl:attribute>
								</a>
								<xsl:call-template name="component-did"/>
							</td>
						</tr>
						<xsl:for-each
							select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
							<tr>
								<td/>
								<td colspan="19" valign="top">
									<xsl:if test="@ead:label">
										<xsl:apply-templates select="@ead:label"/>
										<xsl:text>: </xsl:text>
									</xsl:if>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each
				select="
					ead:scopecontent | ead:bioghist | ead:arrangement
					| ead:userestrict | ead:accessrestrict | ead:processinfo |
					ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
				<xsl:for-each select="ead:p">
					<xsl:choose>
						<!--   Tests to determine if this component has a did element with a container attribute 
						in order to determine the amount of indention required.  ****************   -->
						<xsl:when test="preceding::ead:did[1]/ead:container">
							<tr>
								<td colspan="2"/>
								<td colspan="18">
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:when>
						<!--When there are no container elements associated with this component,
					adjust the columns to the left.  Each paragraph gos on a separate line.-->
						<xsl:otherwise>
							<tr>
								<td colspan="2"/>
								<td colspan="18">
									<!--    Tests to see if this element has a head child.  If so, display it followed by a colon and a space-->
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
			<!--   Processes any other c01 children that follow the did with
				each paragraph on a separate line . -->
			<xsl:apply-templates select="ead:c02"/>
		</table>
	</xsl:template>

	<!--*****  Section 12b:  Transforms c02   ************************************-->
	<xsl:template match="ead:c02">
		<xsl:for-each select="ead:did">
			<!-- ********  There are two xsl:when tests in this template: first to determine whether this did element has 
				a container child or not and then, if it does, to determine whether or not the value of the first container 
				repeats that of the first container in the previous element.-->

			<xsl:choose>
				<!--      If there is a container child....   ********************* -->
				<xsl:when test="ead:container">
					<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
					<xsl:choose>
						<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
							<tr>
								<td> </td>
								<td>
									<xsl:apply-templates select="ead:container[2]"/>
								</td>
								<td colspan="18" valign="top">
									<xsl:call-template name="component-did"/>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
							<tr>
								<td style="font-weight:bold">
									<xsl:apply-templates select="ead:container[1]/@localtype"/>
								</td>
								<td style="font-weight:bold">
									<xsl:apply-templates select="ead:container[2]/@localtype"/>
								</td>
							</tr>
							<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
							<tr>
								<td>
									<xsl:apply-templates select="ead:container[1]"/>
								</td>
								<td>
									<xsl:apply-templates select="ead:container[2]"/>
								</td>
								<td colspan="18" valign="top">
									<xsl:call-template name="component-did"/>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					<!--    Display the remainder of the did children -->
					<xsl:for-each
						select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec">
						<tr>
							<td colspan="3"> </td>
							<td colspan="17" valign="top">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:when>
				<!-- ********  If there is no container child, there is minimal indention....******************* -->
				<xsl:otherwise>
					<tr>
						<td colspan="2"/>
						<td colspan="18" valign="top" style="font-weight:bold">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
					<xsl:for-each
						select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
						<tr>
							<td colspan="2"/>
							<td colspan="18" valign="top">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--   Processes any other c02 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<xsl:choose>
					<!--   Tests to determine if this component has a did element with a container attribute 
						in order to determine the amount of indention required.  ****************   -->
					<!--   If this c02 has a did with containers, intent these remaining elements to the right to accommodate the 
				space taken by the container values.   -->
					<xsl:when test="preceding::ead:did[1]/ead:container">
						<tr>
							<td colspan="3"/>
							<td colspan="17">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:when>
					<!--    If this c02 has no containers associated with it, indent accordingly. -->
					<xsl:otherwise>
						<tr>
							<td colspan="3"/>
							<td colspan="17">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c03"/>
	</xsl:template>

	<!--*****  Section 12c:  Transforms c03   ************************************-->
	<xsl:template match="ead:c03">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td/>
						<td colspan="17" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="2"/>
						<td colspan="16" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="5"> </td>
					<td colspan="15" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c03 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="5"/>
					<td colspan="15">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c04"/>
	</xsl:template>

	<!--   Section 12d:   Transforms c04 ************ -->
	<xsl:template match="ead:c04">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="2"/>
						<td colspan="16" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="2"/>
						<td colspan="16" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="6"> </td>
					<td colspan="14" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c04 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="6"/>
					<td colspan="14">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c05"/>
	</xsl:template>

	<!--   Section 12e:   Transforms c05 ************ -->
	<xsl:template match="ead:c05">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="3"/>
						<td colspan="15" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="3"/>
						<td colspan="15" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="7"> </td>
					<td colspan="13" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c05 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="7"/>
					<td colspan="13">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c06"/>
	</xsl:template>

	<!--   Section 12f:   Transforms  <c06> ************ -->
	<xsl:template match="ead:c06">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="4"/>
						<td colspan="14" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="6"/>
						<td colspan="14" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="8"> </td>
					<td colspan="12" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c06 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="8"/>
					<td colspan="12">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c07"/>
	</xsl:template>

	<!--   Section 12g:   Transforms c07 ************ -->
	<xsl:template match="ead:c07">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="5"/>
						<td colspan="13" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="5"/>
						<td colspan="13" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="9"> </td>
					<td colspan="11" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c07 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="9"/>
					<td colspan="11">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c08"/>
	</xsl:template>

	<!--   Section 12h:   Transforms c08 ************ -->
	<xsl:template match="ead:c08">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="6"/>
						<td colspan="12" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="6"/>
						<td colspan="12" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="10"> </td>
					<td colspan="10" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c08 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="10"/>
					<td colspan="10">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c09"/>
	</xsl:template>

	<!--   Section 12i:   Transforms c09 ************ -->
	<xsl:template match="ead:c09">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="7"/>
						<td colspan="11" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="7"/>
						<td colspan="11" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="11"> </td>
					<td colspan="9" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c09 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="11"/>
					<td colspan="9">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c09"/>
	</xsl:template>

	<!--   Section 12j:   Transforms c10 ************ -->
	<xsl:template match="ead:c09">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="8"/>
						<td colspan="10" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="8"/>
						<td colspan="10" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="12"> </td>
					<td colspan="8" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c10 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="12"/>
					<td colspan="8">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>


	<!--****************** Section 13:   Specifies the content of several generic and named templates which are invoked 
		at various points in the stylesheet.******-->

	<!-- ************ *****  Section 13a:  Creates HTML META tags that are added to the <head> element created in section 1a.***** -->
	<!--	HTML meta tags are inserted into the HTML ouput for use by web search engines indexing this file.  The content of each
					resulting META tag uses Dublin Core semantics and is drawn from the text of the finding aid.-->

	<xsl:template name="metadata">
		<meta http-equiv="Content-Type" name="dc.ead:title"
			content="{ead:control/ead:filedesc/ead:titlestmt/ead:titleproper&#x20; }{ead:control/ead:filedesc/ead:titlestmt/ead:subtitle}"/>
		<meta http-equiv="Content-Type" name="dc.author"
			content="{ead:archdesc/ead:did/ead:origination}"/>
		<xsl:for-each select="//ead:controlaccess/ead:persname | //ead:controlaccess/ead:corpname">
			<xsl:choose>
				<xsl:when test="@encodinganalog = '600'">
					<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '610'">
					<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '611'">
					<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '700'">
					<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '710'">
					<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
				</xsl:when>
				<xsl:otherwise>
					<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="//ead:controlaccess/ead:subject">
			<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
		</xsl:for-each>
		<xsl:for-each select="//ead:controlaccess/ead:geogname">
			<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
		</xsl:for-each>
		<meta http-equiv="Content-Type" name="dc.ead:title"
			content="{ead:archdesc/ead:did/ead:unittitle}"/>
		<meta http-equiv="Content-Type" name="dc.type" content="text"/>
		<meta http-equiv="Content-Type" name="dc.format" content="manuscripts"/>
		<meta http-equiv="Content-Type" name="dc.format" content="finding aids"/>
	</xsl:template>
	<!--***************** Section 13b: Creates a table of contents for the finding. This template is called in Section 1b  ****.-->
	<xsl:template name="toc">
		<h3>TABLE OF CONTENTS</h3>
		<br/>
		<!-- The Table of Contents template performs a series of tests to
		determine which elements will be included in the table
		of contents.  Each if statement tests to see if there is
		a matching element with content in the finding aid.-->
		<xsl:if test="string(ead:archdesc/ead:did/ead:head)">
			<p>
				<b>
					<a href="#{generate-id(ead:archdesc/ead:did/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:did/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:bioghist/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:bioghist/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:bioghist/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:scopecontent/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:scopecontent/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:scopecontent/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:arrangement/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:arrangement/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:arrangement/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:userestrict/ead:head)
				or string(ead:archdesc/ead:accessrestrict/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#restrictlink">
						<xsl:text>Restrictions</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:controlaccess/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:controlaccess/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:controlaccess/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:relatedmaterial)
				or string(ead:archdesc/separatedmaterial)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#relatedmatlink">
						<xsl:text>Related Material</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:acqinfo/*)
				or string(ead:archdesc/ead:processinfo/*)
				or string(ead:archdesc/ead:preferecite/*)
				or string(ead:archdesc/ead:custodialhist/*)
				or string(ead:archdesc/ead:processinfo/*)
				or string(ead:archdesc/ead:appraisal/*)
				or string(ead:archdesc/ead:accruals/*)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#adminlink">
						<xsl:text>Administrative Information</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:prefercite/ead:*)
				or string(ead:archdesc/ead:otherfindaid/ead:*)
				or string(ead:archdesc/ead:bibliography/ead:*)
				or string(ead:archdesc/ead:fileplan/ead:*)
				or string(ead:archdesc/ead:originalsloc/ead:*)
				or string(ead:archdesc/ead:legalstatus/ead:*)
				or string(ead:archdesc/ead:odd/ead:*)
				or string(ead:archdesc/ead:index/ead:*)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#associatedlink">
						<xsl:text>Associated Information</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:dsc/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:dsc/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:dsc/ead:head"/>
					</a>
				</b>
			</p>
			<!-- Displays the unittitle and unitdates for a c01 if it is a
			subgrp, subcollection,series or subseries (as
			evidenced by the value of @level) and numbers them
			to form a hyperlink to each.   Delete this section if you do not
			wish the ead:c01 ead:titles that are so identified
			to appear in the table of contents.-->
			<xsl:for-each
				select="
					ead:archdesc/ead:dsc/ead:c01[@level = 'series' or @level = 'subseries'
					or @level = 'subgrp' or @level = 'subcollection']">
				<p style="margin-top:-5pt; margin-left:15pt; font-size:10pt">
					<b>
						<a>
							<xsl:attribute name="href">
								<xsl:text>#series</xsl:text>
								<xsl:number count="ead:c01" from="ead:dsc"/>
							</xsl:attribute>
							<xsl:apply-templates select="ead:did/ead:unittitle"/>
							<xsl:text>, </xsl:text>
							<xsl:apply-templates select="ead:did/ead:unitdate"/>
						</a>
					</b>
				</p>
			</xsl:for-each>
			<!--This ends the section that causes the c01 titles to appear in the table of contents.-->
		</xsl:if>
		<!--End of the table of contents. -->
	</xsl:template>

	<!-- ********** Section 13c.  Defines the display sequence of elements for the whole of archdesc..-->
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
		<xsl:apply-templates select="ead:archdesc/ead:dsc"/>
	</xsl:template>

	<!-- ********* Section 13d.  A generic template that formats and supplies punctuation for the "access" 
		elements in repository,	origination and controlaccess that have a child part element.	 Punctuation 
		is base on the values in @localtype which are assumed to follow the conventionns of MARC21.   
		Excluded are parts of titles that are children of title in a paragraph.-->
	<xsl:template
		match="
			ead:persname/ead:part | ead:corpname/ead:part | ead:famname/ead:part |
			ead:name/ead:part | ead:subject/ead:part | ead:title[not(parent::ead:p)]/ead:part | ead:function/ead:part
			| ead:occupation/ead:part | ead:geogname/ead:part | ead:genreform/ead:part">
		<!--   There are four secenarios for handling the part element and its punctuation. -->
		<xsl:choose>
			<!-- The first scenario occurs when there is no @localtype.  Each part element 
				is processed and a generic period and space are inserted following it.-->
			<xsl:when test="not[@localtype]">
				<xsl:apply-templates/>
				<xsl:text>.&#x20;</xsl:text>
			</xsl:when>
			<!--	 The second scenario is where there is an @localtype AND this particlar part element is 
				not the last child of its parent element AND the value of @localtype is not a q, 
				a name qualifier that must be inserted between square brackets.	
				The supplied punctuation for each part depends on the value of the following part.  -->
			<xsl:when test="position() != last() and @localtype != 'q'">
				<!-- Proceess the part element -->
				<xsl:apply-templates/>
				<!-- Insert punctuation following this part.  The particular punctuation inserted depends
				on the @localtype for the following part.-->
				<xsl:if
					test="
						following-sibling::ead:part[1][@localtype = 'v'] or following-sibling::ead:part[1][@localtype = 'x']
						or following-sibling::ead:part[1][@localtype = 'y'] or following-sibling::ead:part[1][@localtype = 'z']">
					<xsl:text>--</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype = 'b']">
					<xsl:text>.&#x20;</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype = 'q']">
					<xsl:text>&#x20;[</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype = 'd']">
					<xsl:text>,&#x20;</xsl:text>
				</xsl:if>
			</xsl:when>
			<!--When @localtype is a q, apply the template and insert a following square bracket.  -->
			<xsl:when test="@localtype = 'q'">
				<xsl:apply-templates/>
				<xsl:text>]&#x20;</xsl:text>
			</xsl:when>
			<!-- In all other cases such as when this part is the last child of 
			its parent, apply the template and add a following period and space. -->
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:text>.&#x20;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********** Section 13e.  Formats one or more phydescstructured elements in archdesc/did.   This named template 
		is called for physdesctructured element in section 3e for archdesc/did and in section 12m for component/did elements.********************************************-->
	<!--    This template does not attempt to process all conceivable scenarios with this element since so many encoding variations are possible.
		
					Several issues arise with this element.
					
					1.  With four possible values for @physdescstructured and two for @coverage, the number of possible variations in encoding is quite large
					2.  There is slim guidance in archival descriptive standards as to the proper way to display this information.
					3.  The author of this stylesheet does not believe that simply stating the number of boxes or cubic feet occupied is sufficiently 
							informative about the extent of the materials for most researcher.   
					4.	Some of terms used in statements of extent, e.g. cubic feet and linear feet, are as mysterious to most researchers as the expectation of library catalogers
							that users somehow understand that the initials s.n. stands for the Latin expression sine nomine.  This stylesheet attempts to clarify this situation for archival 
							descriptions by including text that hopefully more clearly explains the content.  If you do't like this approach, change or delete the text and/or insert punctuation as
							you feel best.-->
	<!--		This template concatenates one or more physdescstructred elements into a single text string. 
					It processes the first occurence of physdescstructured and then appends any subsequent physdescstructured elements.  Explanatory text is inseted before any subsequent 
					elements.  
					
					The template uses an xsl:choose element to select and transform one of three possible encoding scenarios, based on the value of the attribute physdescstructuredtype.
					
					1. when the first physdescstructured element has the @physdescstructuredtype value of "spaceoccupied", followed by a @physdescstructuredtype='carrier' 
							and/or physdescstructuredtype='materialtype' if either or both are present.
					2. when the first physdescstructured element has the @physdescstructuredtype value of "carrier", followed by a @physdescstructuredtype='spaceoccupied' 
							and/or a @physdescstructuredtype='materialtype' if either or both are present
							if they are present.
					3. when the first physdescstructured element has the @physdescstructuredtype value of "materialtype", followed by a @physdescstructuredtype='carrier' 
							and/or @physdescstructuredtype='spaceoccupied' if either or both they are present.-->

	<xsl:template name="concat-physdescstructured">
		<!-- Scenario 1: when the first physdescstructed element has the @physdescstructuredtype value of "spaceoccupied", optionally followed by 
			other physdesstructured elements that have @physdescstructuredtype='carrier' and/or @physdescstructuredtype='materialtype'. -->
		<xsl:choose>
			<xsl:when test="position() = '1' and ./@physdescstructuredtype = 'spaceoccupied'">
				<!-- Insert its quantity and type with a blank space between them-->
				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='carrier', insert the word "in" and a blank space,
				then its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']">
					<xsl:text> in  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:unittype"
					/>
				</xsl:if>

				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='materialtype', insert the words "consisting of" and a blank space,
				then its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']">
					<xsl:text> and consisting of </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<!-- Scenario 2: When the first physdescstructed element has the @physdescstructuredtype="carrier", optionally followed by 
			other physdesstructured elements that have @physdescstructuredtype='spaceoccupied' and/or @physdescstructuredtype='materialtype'-->
			<xsl:when test="position() = '1' and ./@physdescstructuredtype = 'carrier'">
				<!-- Insert its quantity and type with a blank space between them-->
				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='spaceoccupied', insert the word "occupying" with blank spaces
					surrounding it,	then inset its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']">
					<xsl:text> occupying </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:unittype"
					/>
				</xsl:if>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredype='materialtype', insert the words "and consisting of" with blank spaces
					surrounding it, then insert its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured/@physdescstructuredtype = 'materialtype'">
					<xsl:text> and consisting of </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<!-- Scenario 3 When the first physdescstructed element has the @physdescstructuredtype="materialtype", optionally followed by 
			other physdesstructured elements that have @physdescstructuredtype='carrier' and/or @physdescstructuredtype='spaceoccupied'-->
			<xsl:when test="position() = '1' and ./@physdescstructuredtype = 'materialtype'">
				<!-- Insert its quantity and type with a blank space between them-->
				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='carrier', insert the word "in" with blank spaces
					surrounding it,	then inset its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructured = 'carrier']">
					<xsl:text> in </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:unittype"/>
					<xsl:text> </xsl:text>
				</xsl:if>

				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='spaceoccupied', insert the word "occupying" with blank spaces
					surrounding it,	then inset its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']">
					<xsl:text>  occupying </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<xsl:otherwise>
				<!--By providing no transformation specifications, suppress additional physdescstructured elements in position 2 and 3 as they 
					have already been processed.-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********** Section 13f: Formats the dao element wherever it occurs. ******************************************************-->

	<xsl:template name="dao-generic">
		<img src="{@href}">
			<xsl:apply-templates select="self::ead:dao[not(child::ead:descriptivenote)]"/>
		</img>
	</xsl:template>

	<!-- ********** Section 13g:.  Formats title and emph elemtents that have a @render attribute.************************************* -->
	<xsl:template match="ead:emph[@render = 'bold']">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'italic']">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'underline']">
		<u>
			<xsl:apply-templates/>
		</u>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'sub']">
		<sub>
			<xsl:apply-templates/>
		</sub>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'super']">
		<super>
			<xsl:apply-templates/>
		</super>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'quoted']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'doublequote']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'singlequote']">
		<xsl:text>'</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>'</xsl:text>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'bolddoublequote']">
		<b>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'boldsinglequote']">
		<b>
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'boldunderline']">
		<b>
			<u>
				<xsl:apply-templates/>
			</u>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'bolditalic']">
		<b>
			<i>
				<xsl:apply-templates/>
			</i>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'boldsmcaps']">
		<b style="font-variant:small-caps">
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'smcaps']">
		<div style="font-variant:small-caps">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'bold']">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'italic']">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'underline']">
		<u>
			<xsl:apply-templates/>
		</u>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'sub']">
		<sub>
			<xsl:apply-templates/>
		</sub>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'super']">
		<super>
			<xsl:apply-templates/>
		</super>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'quoted']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'doublequote']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'singlequote']">
		<xsl:text>'</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>'</xsl:text>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'bolddoublequote']">
		<b>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'boldsinglequote']">
		<b>
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'boldunderline']">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'bolditalic']">
		<b>
			<i>
				<xsl:apply-templates/>
			</i>
		</b>
	</xsl:template>

	<xsl:template match="ead:title[@render = 'boldsmcaps']">
		<b style="font-variant:small-caps">
			<xsl:apply-templates/>
		</b>
	</xsl:template>

	<xsl:template match="ead:title[@render = 'smcaps']">
		<div style="font-variant:small-caps">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- ***********Section 13h:  Formats the ref element. -->
	<!-- This template converts a Ref element into an HTML anchor.-->

	<xsl:template match="ead:ref">
		<xsl:if test="self::ead:ref[@href]">
			<img src="#{@href}">
				<xsl:apply-templates/>
			</img>
		</xsl:if>
		<xsl:if test="self::ead:ref[@show = 'new']">
			<a href="{@href}">
				<xsl:apply-templates/>
			</a>
		</xsl:if>
		<xsl:if test="self::ead:ref[@target]">
			<a href="#{@target}">
				<xsl:apply-templates/>
			</a>
		</xsl:if>
	</xsl:template>


	<!--**********Section  13i:  Formats a list element everywhere except in arrangement.  List in <arrangement> 
		are handled in the template for <arrangement>.    ************************-->

	<!--The next two templates format the <head> and <p> of a list element wherever 
		it occurs.-->
	<xsl:template match="ead:list[parent::*[not(self::ead:arrangement)]]/ead:head">
		<div style="margin-left: 25pt">
			<b>
				<xsl:apply-templates/>
			</b>
		</div>
	</xsl:template>
	<xsl:template match="ead:list[parent::*[not(self::ead:arrangement)]]/ead:item">
		<div style="margin-left: 40pt">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!--************Section 13j:  Formats a simple table.****-->
	<!--	The width of each column is defined by the colwidth attribute in a colspec element.-->
	<!--************Section 13j:  Formats a simple table.****-->


	<xsl:template match="ead:table">
		<table width="75%" style="margin-left: 25pt">
			<tr>
				<td coldiv="3">
					<h4>
						<xsl:apply-templates select="ead:head"/>
					</h4>
				</td>
			</tr>
			<xsl:for-each select="ead:tgroup">
				<tr>
					<xsl:for-each select="ead:colspec">
						<td width="{@colwidth}"/>
					</xsl:for-each>
				</tr>
				<xsl:for-each select="ead:thead">
					<xsl:for-each select="ead:row">
						<tr>
							<xsl:for-each select="ead:entry">
								<td valign="top">
									<b>
										<xsl:apply-templates/>
									</b>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</xsl:for-each>
				<xsl:for-each select="ead:tbody">
					<xsl:for-each select="ead:row">
						<tr>
							<xsl:for-each select="ead:entry">
								<td valign="top">
									<xsl:apply-templates/>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!-- ********** Section 13k:  Formats a chronlist element.   *********************************************************************-->

	<!-- ********** To accomodate the many variations that are possible in <chronlist>, this template has many 
	conditional if/then type statements.   They are heavily annotated both at the beginning of each conditional 
	statement but also at the end to mark the sections into logical segments.-->

	<xsl:template name="chronlist-generic">
		<table width="100%">
			<tr>
				<td width="20%"> </td>
				<td width="30%"> </td>
				<td width="50%"> </td>
			</tr>

			<xsl:for-each select="ead:head">
				<tr>
					<td colspan="3">
						<h4>
							<xsl:apply-templates/>
						</h4>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="ead:listhead">
				<tr>
					<td>
						<b>
							<xsl:apply-templates select="ead:head01"/>
						</b>
					</td>
					<td>
						<b>
							<xsl:apply-templates select="ead:head02"/>
						</b>
					</td>
					<td>
						<b>
							<xsl:apply-templates select="ead:head03"/>
						</b>
					</td>
				</tr>
			</xsl:for-each>

			<xsl:for-each select="ead:chronitem">

				<!-- Transform a chronitem that does not have a chronitemset child. -->
				<xsl:choose>
					<xsl:when test="not(child::ead:chronitemset)">
						<tr>
							<!-- Tests whether there is a single date or a daterange -->
							<xsl:choose>
								<!-- 	Transform single dates -->

								<xsl:when test="ead:datesingle">
									<td>
										<xsl:apply-templates select="ead:datesingle"/>
									</td>
								</xsl:when>
								<!-- Transform date ranges -->

								<xsl:when test="ead:daterange">
									<td>
										<xsl:apply-templates select="ead:daterange/ead:fromdate"/>
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="ead:daterange/ead:todate"/>
									</td>
								</xsl:when>
							</xsl:choose>
							<!-- Closes the test for single or range dates -->

							<!-- Adds the event and geogname children of this chronitem that has not chronitemsets -->
							<td>
								<xsl:apply-templates select="ead:event"/>
							</td>
							<td>
								<xsl:apply-templates select="ead:geogname"/>
							</td>
						</tr>
					</xsl:when>
					<!-- Closes the transformation of chronitems that have no chronitemset children -->

					<!-- Otherwise transform chronitems that have chronitemset children.   There are four possible 
					scenarios-->

					<!-- Begins the transformation of chronitems that have chronitemset children -->
					<xsl:when test="ead:chronitemset">


						<!-- Scenario 1: The chronitemset has one and only one event and one and only one geoganme, i.e. 
								the value of first and last event are the same and the value of the first and last geogname are the same. 
							This markup is used when a date is associated with more than one event and more than one geogname. -->

						<xsl:choose>
							<xsl:when test="ead:chronitemset[1] != ead:chronitemset[last()]">


								<tr>
									<xsl:choose>
										<!-- Tests for a single date or daterange -->

										<!-- 	Transform single dates -->
										<xsl:when test="ead:datesingle">
											<td>
												<xsl:apply-templates select="ead:datesingle"/>
											</td>
										</xsl:when>

										<!-- Transform date ranges -->
										<xsl:when test="ead:daterange">
											<td>
												<xsl:apply-templates
												select="ead:daterange/ead:fromdate"/>
												<xsl:text>-</xsl:text>
												<xsl:apply-templates
												select="ead:daterange/ead:todate"/>
											</td>
										</xsl:when>
									</xsl:choose>
									<!-- Closes the transformation of the date elements -->



									<!-- Transform the first chronitemset on one row. -->
									<td>
										<xsl:apply-templates select="ead:chronitemset[1]/ead:event"/>

									</td>
									<td>
										<xsl:apply-templates
											select="ead:chronitemset[1]/ead:geogname"/>
									</td>
								</tr>
								<!-- Closes the row with the first chronitemset -->

								<!-- Transform additional chronitemsets into additional rows -->
								<xsl:for-each select="ead:chronitemset[position() > 1]">
									<tr>
										<td/>
										<td>
											<xsl:apply-templates select="ead:event"/>
										</td>
										<td>
											<xsl:apply-templates select="ead:geogname"/>
										</td>
									</tr>
								</xsl:for-each>
								<!-- Ends the transformation of additional chronitemsets and ends Scenario 1 -->
							</xsl:when>


							<!-- Scenario 2 chronitemset has one and only one event and more than one geoganme, i.e.
								the value of the first and the value of the last event are the same (there is only one) and 
								the value of the first geogname is NOT the same as the value of the last geogname (there are more than one). -->

							<xsl:when
								test="ead:chronitemset/ead:event[1] = ead:chronitemset/ead:event[last()] and ead:chronitemset/ead:geogname[1] != ead:chronitemset/ead:geogname[last()]">
								<tr>
									<!-- Tests for a single date or daterange -->
									<xsl:choose>

										<!-- Transform single dates -->
										<xsl:when test="ead:datesingle">
											<td>
												<xsl:apply-templates select="ead:datesingle"/>
											</td>
										</xsl:when>

										<!-- Transform date ranges -->
										<xsl:when test="ead:daterange">
											<td>
												<xsl:apply-templates
												select="ead:daterange/ead:fromdate"/>
												<xsl:text>-</xsl:text>
												<xsl:apply-templates
												select="ead:daterange/ead:todate"/>
											</td>
										</xsl:when>
									</xsl:choose>
									<!-- Closes the transformation of dates -->

									<!-- Transforms the first event and first geogname children in the chronitemset  -->
									<td>
										<xsl:apply-templates select="ead:chronitemset/ead:event[1]"
										/>
									</td>
									<td>
										<xsl:apply-templates
											select="ead:chronitemset/ead:geogname[1]"/>
									</td>
								</tr>

								<!-- Transform each additional geogname element in the chronitemset into an additional row -->
								<xsl:for-each select="ead:chronitemset/ead:geogname[position() > 1]">
									<tr>
										<td/>
										<td/>
										<td>
											<xsl:apply-templates/>
										</td>
									</tr>
								</xsl:for-each>
								<!-- Ends the transformation of chronitemsets and ends Scenario 2. -->
							</xsl:when>

							<!-- Scenario 3: chronitem set has one and only one geogname and more than one event, i.e.
								the value of the first and the value of the last geogname are the same (there is only one) and 
								the value of the first event is NOT the same as the value of the last event (there are more than one).-->

							<xsl:when
								test="ead:chronitemset/ead:geogname[1] = ead:chronitemset/ead:geogname[last()] and ead:chronitemset/ead:event[1] != ead:chronitemset/ead:event[last()]">

								<!-- Opens a row -->
								<tr>

									<!-- Tests for a single date or daterange -->
									<xsl:choose>

										<!-- 	Transform single dates -->
										<xsl:when test="ead:datesingle">
											<td>
												<xsl:apply-templates select="ead:datesingle"/>
											</td>
										</xsl:when>

										<!-- Transform date ranges -->
										<xsl:when test="ead:daterange">
											<td>
												<xsl:apply-templates
												select="ead:daterange/ead:fromdate"/>
												<xsl:text>-</xsl:text>
												<xsl:apply-templates
												select="ead:daterange/ead:todate"/>
											</td>
										</xsl:when>

										<!-- Ends the transformation of date(s) -->
									</xsl:choose>

									<!-- Transforms the first event and first geogname in the chronitemset  -->
									<td>
										<xsl:apply-templates select="ead:chronitemset/ead:event[1]"
										/>
									</td>
									<td>
										<xsl:apply-templates select="ead:chronitemset/ead:geogname"
										/>
									</td>

									<!-- Closes the row -->
								</tr>
								<!-- Ends the transformation  of the first event and geogname element in this 
							 chronitemset.-->

								<!-- Transforms each additional event element in the chronitemset into an additional row -->
								<xsl:for-each select="ead:chronitemset/ead:event[position() > 1]">
									<tr>
										<td/>
										<td>
											<xsl:apply-templates/>
										</td>
										<td/>
									</tr>
								</xsl:for-each>

								<!--Ends scenario 3-->
							</xsl:when>

							<!-- Closes the transformation of chronitems with chronitemset children -->
						</xsl:choose>

						<!-- Ends for each chronitem -->
					</xsl:when>

					<!-- Closes the choice between chronitems that have chronitmset children and those that don't. -->
				</xsl:choose>

				<!-- Closes the transformation of each chronitem. -->
			</xsl:for-each>
		</table>
	</xsl:template>


	<!-- **** The following two named templates apply to all components.   This reduces the amount of code since manny of these elements display 
		the same at every level except for their horizontal position (indention) in the table created for each c01.  Positioning in the table is 
		controled by HTML table row and table data <td> elements. Empty <td> elements are used to position data horizontally on a given row.-->

	<!-- *Section 13l:  Formats basic did elements for all component levels.  **********************************************************	-->

	<!--This template formats the unitid, origination, unittitle,	unitdate, and physdesc elements of components at all levels.  It calls another named template 
		for physdescstructured which is included in this string if it appears in a component.  These elements are concatenated into a single text string and
		appear, along with any container elements,on a separate line from other did child elements in components.   This template is generic to all component levels.-->
	<xsl:template name="component-did">
		<!--Inserts unitid and a space if it exists in the markup.-->
		<xsl:if test="ead:unitid">
			<xsl:apply-templates select="ead:unitid"/>
			<xsl:text>&#x20;.</xsl:text>
		</xsl:if>
		<xsl:if test="ead:unittitle">
			<xsl:choose>
				<xsl:when
					test="ead:unittitle[following-sibling::ead:unitdate or following-sibling::ead:unitdatestructured]">
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
		<xsl:if test="ead:unitdatestructured">
			<xsl:call-template name="unitdatedstructured-common"/>
		</xsl:if>
	</xsl:template>

	<!-- ********* Section: 13m:    Shared formating of unitdatestructured in several contexts. **************************-->
	<!-- *******  This named template formats unitdatestructured in both archdesc/did and component/did elements.*********** 
				It is called by the immediately preceding named template "component-did" (Section 13l) which transforms 
				unitdatestructured in components and by the template (Section 3d) which transforms unitdatestructured 
				in archdesc/did.-->

	<xsl:template name="unitdatedstructured-common">
		<!--   	Some fancy footwork with punctuation around the presence or absence of dateset and the order of datesingle and daterange elements.
			Results may vary.  This template sorts datesingle and fromdate elements into a single chronological order if they 
			are not already and supplies separating puncuation.-->

		<!-- There are two possibilities in encoding with the unitdatestructured element: 
			1.  when dateset is used as a child of unitdatestructured, wrapping datesingle and/or daterange elements
				into a set.
			2.  when dateset is not used and there one or more datesingle elements OR one or 
				more daterange elements that are the direct children of unitdatestructured
						-->
		<!-- Scenario 1: When dateset is used as a wrapper.-->
		<xsl:choose>
			<xsl:when test="ead:dateset">

				<!-- Arranges the dates in chronological order if they are not already.-->
				<xsl:for-each
					select="ead:dateset/ead:datesingle | ead:dateset/ead:daterange/ead:fromdate">
					<xsl:sort select="." data-type="number"/>
					<xsl:value-of select="."/>

					<!-- Inserts a dash between fromdate and todate elements. -->
					<xsl:if test="self::ead:fromdate">
						<xsl:text>-</xsl:text>
						<xsl:value-of select="following-sibling::ead:todate"/>
					</xsl:if>

					<!--Inserts a comma between dates and dateranges and inserts a period following the last date.  -->
					<xsl:choose>
						<xsl:when test="position() != last()">
							<xsl:text>,&#x20;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>

			<!-- Scenario 2:    When unitdatestructured does not have a dateset child. 
					Unitdatestructured may have either datesingle OR daterange
					elements as children but not a mixture of both.-->

			<xsl:otherwise>
				<!-- Arranges the dates in chronological order if they are not already. -->
				<xsl:for-each select="ead:datesingle | ead:daterange/ead:fromdate">
					<xsl:sort select="." data-type="number"/>
					<xsl:value-of select="."/>

					<!-- Inserts a dash between fromdate and todate elements. -->
					<xsl:if test="self::ead:fromdate">
						<xsl:text>-</xsl:text>
						<xsl:value-of select="following-sibling::ead:todate"/>
					</xsl:if>

					<!--Inserts a comma between dates and dateranges and inserts a period following the last date.  -->
					<xsl:choose>
						<xsl:when test="position() != last()">
							<xsl:text>,&#x20;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--  *********Section 13n:   Transforms container elements and determines their display *********************************************************************-->
	<!--			This template determines whether column display heads like Box and Folder appear and whether unique first containers 
					are displayed or suppressed. For an alternative approach based the values of the 
					@localtype attribute rather than the position of the <container> elements, see 
					the "commented out" template that follows this one.-->

	<xsl:template name="container-display">
		<xsl:choose>
			<xsl:when test="ead:container[1] = ../parent/preceding::did[1]/ead:did/ead:container[1]">
				<tr>
					<td/>
					<td> </td>
					<td colspan="18">
						<xsl:call-template name="component-did"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<b>
							<xsl:text>Box</xsl:text>
						</b>
					</td>
					<td>
						<b>
							<xsl:text>Folder</xsl:text>
						</b>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:value-of select="ead:container[1]"/>
					</td>
					<td>
						<xsl:value-of select="ead:container[2]"/>
					</td>
					<td colspan="18">
						<xsl:call-template name="component-did"/>
					</td>

				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--  The following template was employed in earlier stylesheets written for EAD2002.  The following code governs the display of container values and columns heads
	based on the content of the type (now localtype) attribute rather than by the position of the container element (i.e first container or second container) which 
	is the default in this stylesheet.  The default approach assumes that where box and folder container elements are included, both are represented alway in the encoding
	even when the value of the box number repeats that of previous box numbers.  One can substitute the following for the default code.  It needs to be inserted
	for components at every level.  The former attribute TYPE has bn replaced by the new attribute LOCALTYPE in EAD3.-->

	<!--The next two variables define the set of container types that may appear in the first column of a two column container list.
			Add or subtract ead:container types to fix institutional practice.
		<xsl:variable name="first"
			select="
				ead:container[@localtype = 'Box'
				or @localtype = 'Oversize' or @localtype = 'Volume' or @localtype = 'Carton' or @localtype = 'Reel' or @localtype = 'reel' or
				@localtype = 'box' or @localtype = 'oversize' or @localtype = 'volume' or @localtype = 'carton']"/>
		This variable defines the set of ead:container types that
		may appear in the second column of a two column ead:container list.
		Add or subtract ead:container types to fix institutional practice.
		<xsl:variable name="second"
			select="
				ead:container[@localtype = 'Folder'
				or @localype = 'Frame' or @localtype = 'Page' or @localtype = 'Reel' or @localtype = 'folder'
				or @localtype = 'frame' or @localtype = 'page' or @localtype = 'reel']"/>
		<xsl:variable name="preceding"
			select="
				preceding::ead:did[1]/ead:container[@localtype = 'Box'
				or @localtype = 'Oversize' or @localtype = 'Volume' or @localtype = 'Carton' or
				@localtype = 'box' or @localtype = 'Reel' or @localtype = 'reel' or @localtype = 'oversize' or @localtype = 'volume' or @localtype = 'carton']"/>
		<xsl:choose>
When the ead:container value or the ead:container type of the first
			 ead:container is not are the same as that of the comparable ead:container
			in the previous component, insert column heads and the contents of
			the ead:container elements.
			
			<xsl:when
				test="
					$first and (not($preceding = $first) or
					not($preceding/@localtype = $first/@localtype))">
				<tr>
					<td>
						<b>
							<xsl:value-of select="$first/@localtype"/>
						</b>
					</td>
					<td>
						<b>
							<xsl:value-of select="$second/@localtype"/>
						</b>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<xsl:apply-templates select="$first"/>
					</td>
					<td valign="top">
						<xsl:apply-templates select="$second"/>
					</td>
					<td valign="top" colspan="18">
						<b>
							<xsl:call-template name="component-did"/>
						</b>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td valign="top"> </td>
					<td valign="top">
						<xsl:value-of select="$second"/>
					</td>
					<td valign="top" colspan="18">
						<b>
							<xsl:call-template name="component-did"/>
						</b>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>-->
</xsl:stylesheet>
