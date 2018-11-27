Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 83F4B6BF43
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 06:05:07 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gRWUc-0004US-1I from Awais_Belal@mentor.com ;
	Mon, 26 Nov 2018 22:05:06 -0800
Received: from [137.202.156.92] (137.202.0.90) by
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Tue, 27 Nov 2018 06:05:01 +0000
To: "Ugesh Munirajulu (RBEI/ECG-EP3)" <Ugesh.Munirajulu@in.bosch.com>,
	"kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>, Bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <119490492.5831423.1543217793985.ref@mail.yahoo.com>
	<119490492.5831423.1543217793985@mail.yahoo.com>
	<5a9fde61-7134-2abf-4eae-18bb9ba4b8cb@mentor.com>
	<0039a6a94bda4b92a055a70222f1ba33@in.bosch.com>
From: Awais Belal <awais_belal@mentor.com>
Message-ID: <8872afb6-e079-7464-1e65-800729bb2d67@mentor.com>
Date: Tue, 27 Nov 2018 11:05:00 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0039a6a94bda4b92a055a70222f1ba33@in.bosch.com>
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Subject: Re: Copying the files to sysroot
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 27 Nov 2018 06:05:07 -0000
Content-Type: multipart/alternative;
	boundary="------------F949F5A7865FF18F255AD1A9"
Content-Language: en-US

--------------F949F5A7865FF18F255AD1A9
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ugesh,

 >> Where is the ${includedir} points too? by default it is /usr/ by GNU 
itself. is it somewhere redefined?

The includedir points to /usr/include under the ${D} which is 
${WORKDIR}/image. To be precise the includedir is directly set to 
${exec_prefix}/include where exec_prefix is usually set to /usr

 >> if [ ! -e $(includedir)/componentincludes ]; then

this if looks incorrect to me. It should probably be

if [ ! -e ${D}${includedir}/componentincludes ]; then

Please also move your inherit lines just below SRC_URI as keeping 
inheritance on top of everything is a good practice and would avoid some 
issues. Once you make these changes please rerun bitbake for this .bb 
file and then look at ${WORKDIR}/temp/log.do_install. The sysroot will 
not be populated with these headers unless one of the recipes DEPENDS on 
this first recipe. Also, in current implementation every recipe has its 
own sysroot components under ${WORKDIR}/recipe-sysroot/. So you need to 
look in <2nd-recipe-workdir>/recipe-sysroot/

BR,
Awais

On 26/11/18 17:05, Ugesh Munirajulu (RBEI/ECG-EP3) wrote:
>
> Hello Awals,
>
> If, I am correct the ${D} points to ${WORKDIR}/image
>
> Where is the ${includedir} points too? by default it is /usr/ by GNU 
> itself. is it somewhere redefined?
>
> Please find the my .bb file
>
> DESCRIPTION = "First Application"
>
> SECTION = "MyLayer"
>
> LICENSE = "MIT"
>
> LIC_FILES_CHKSUM = 
> "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
>
> #LIC_FILES_CHKSUM = "file://LICENSE;md5=c00933139e794019cd555c2848de3d19"
>
> PR = "r0"
>
> SRC_URI = "file://component-0.1.tar.gz"
>
> S = "${WORKDIR}/recipes-component-0.1/"
>
> do_install_append() {
>
> if [ ! -e $(includedir)/componentincludes ]; then
>
> install -d ${D}${includedir}/componentincludes;
>
> fi
>
> install -m 644 ${S}/inc/*.h ${D}${includedir}/componentincludes
>
> }
>
> inherit autotools pkgconfig
>
> inherit gettext
>
> _local.conf:_
>
> __
>
> _ACHINE ??= 'imx8mqevk'_
>
> _DISTRO ?= 'fsl-imx-wayland'_
>
> _PACKAGE_CLASSES ?= "package_rpm"_
>
> _EXTRA_IMAGE_FEATURES ?= "debug-tweaks"_
>
> _USER_CLASSES ?= "buildstats image-mklibs image-prelink"_
>
> _PATCHRESOLVE = "noop"_
>
> _BB_DISKMON_DIRS ??= "\_
>
> _STOPTASKS,${TMPDIR},1G,100K \_
>
> _STOPTASKS,${DL_DIR},1G,100K \_
>
> _STOPTASKS,${SSTATE_DIR},1G,100K \_
>
> _STOPTASKS,/tmp,100M,100K \_
>
> _ABORT,${TMPDIR},100M,1K \_
>
> _ABORT,${DL_DIR},100M,1K \_
>
> _ABORT,${SSTATE_DIR},100M,1K \_
>
> _ABORT,/tmp,10M,1K"_
>
> _PACKAGECONFIG_append_pn-qemu-native = " sdl"_
>
> _PACKAGECONFIG_append_pn-nativesdk-qemu = " sdl"_
>
> _CONF_VERSION = "1"_
>
> __
>
> _DL_DIR ?= "${BSPDIR}/downloads/"_
>
> _ACCEPT_FSL_EULA = "1"_
>
> With the above configuration the files are not copied to 
> sysroot/usr/include/componentincludes.
>
> Best regards,
>
> *Munirajulu Ugesh
> RBEI/ECG-EP3
> *
> Tel. +91 422 676-4710
>
> *From:*Awais Belal <awais_belal@mentor.com>
> *Sent:* Monday, November 26, 2018 5:22 PM
> *To:* kumar.ugesh003@yahoo.com; Bitbake-devel 
> <bitbake-devel@lists.openembedded.org>
> *Cc:* Ugesh Munirajulu (RBEI/ECG-EP3) <Ugesh.Munirajulu@in.bosch.com>
> *Subject:* Re: [bitbake-devel] Copying the files to sysroot
>
> Hi Ugesh,
>
> >> 1. I want to copy the header includes to sysroot/usr/include/component
>
> Simply install the header files to ${D}${includedir}/component at the 
> end of your 1st recipe's do_install.
>
> e.g.
>
> mkdir -p ${D}${includedir}/component
>
> install -m 0644 <HEADER_LOCATION>/<header>.h ${D}${includedir}/component/
>
> >> 2. Another recipe shall be able to refer the header from 
> sysroot/usr/include/component
>
> Add your 1st recipe's package name in the DEPENDS of the recipe where 
> you want to utilize these headers.
>
> BR,
> Awais
>
> On 26/11/18 12:36, Ugesh Reddy via bitbake-devel wrote:
>
>     Hello All,
>
>     I have the yocto bsp for iMx8 eval board and compiled it
>     successfully. I have introduced the new custom layer and written
>     .bb file for my recipe and the component is compiled successfully
>     and want to install the my include in
>     sysroot/usr/include/component at the end. I don't have the clue
>     how to do that . Could you please some one guide me.
>
>     I want the below to be achieved from .bb files.
>
>     1. I want to copy the header includes to sysroot/usr/include/component
>
>     2. Another recipe shall be able to refer the header from
>     sysroot/usr/include/component
>
>     Regards,
>
>     Ugesh
>
>
>


--------------F949F5A7865FF18F255AD1A9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Ugesh,</p>
    <p>&gt;&gt; <span style="font-family:&quot;Tahoma&quot;,sans-serif">Where
        is the ${includedir} points too? by default it is /usr/ by GNU
        itself. is it somewhere redefined?</span></p>
    <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">The
        includedir points to /usr/include under the ${D} which is
        ${WORKDIR}/image. To be precise the includedir is directly set
        to ${exec_prefix}/include where exec_prefix is usually set to
        /usr<br>
      </span></p>
    <p>&gt;&gt; <span style="font-family:&quot;Tahoma&quot;,sans-serif">if
        [ ! -e $(includedir)/componentincludes ]; then <br>
      </span></p>
    <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">this if
        looks incorrect to me. It should probably be</span></p>
    <p><span style="font-family:&quot;Tahoma&quot;,sans-serif"><span
          style="font-family:&quot;Tahoma&quot;,sans-serif">if [ ! -e
          ${D}${includedir}/componentincludes ]; then</span></span></p>
    <p><span style="font-family:&quot;Tahoma&quot;,sans-serif"><span
          style="font-family:&quot;Tahoma&quot;,sans-serif">Please also
          move your inherit lines just below SRC_URI as keeping
          inheritance on top of everything is a good practice and would
          avoid some issues. Once you make these changes please rerun
          bitbake for this .bb file and then look at ${WORKDIR}/temp/log.do_install.
          The sysroot will not be populated with these headers unless
          one of the recipes DEPENDS on this first recipe. Also, in
          current implementation every recipe has its own sysroot
          components under ${WORKDIR}/recipe-sysroot/. So you need to
          look in &lt;2nd-recipe-workdir&gt;/recipe-sysroot/<br>
        </span></span></p>
    <pre class="moz-signature" cols="72">BR,
Awais</pre>
    <div class="moz-cite-prefix">On 26/11/18 17:05, Ugesh Munirajulu
      (RBEI/ECG-EP3) wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:0039a6a94bda4b92a055a70222f1ba33@in.bosch.com">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Consolas",serif;
	color:black;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">Hello
            Awals,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">If, I am
            correct the ${D} points to ${WORKDIR}/image<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">Where is
            the ${includedir} points too? by default it is /usr/ by GNU
            itself. is it somewhere redefined?<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">Please
            find the my .bb file
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">DESCRIPTION
            = "First Application"<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">SECTION =
            "MyLayer"<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">LICENSE =
            "MIT"<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">LIC_FILES_CHKSUM
            =
            <a class="moz-txt-link-rfc2396E" href="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302">"file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"</a><o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">#LIC_FILES_CHKSUM
            = <a class="moz-txt-link-rfc2396E" href="file://LICENSE;md5=c00933139e794019cd555c2848de3d19">"file://LICENSE;md5=c00933139e794019cd555c2848de3d19"</a><o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">PR = "r0"<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">SRC_URI =
            <a class="moz-txt-link-rfc2396E" href="file://component-0.1.tar.gz">"file://component-0.1.tar.gz"</a><o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">S =
            "${WORKDIR}/recipes-component-0.1/"<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">do_install_append()
            {       
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">         
            if [ ! -e $(includedir)/componentincludes ]; then
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">                   
            install -d ${D}${includedir}/componentincludes;<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">         
            fi<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">         
            install -m 644 ${S}/inc/*.h
            ${D}${includedir}/componentincludes<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">}<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">inherit
            autotools pkgconfig<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">inherit
            gettext<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">local.conf:<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p><span
                  style="text-decoration:none"> </span></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">ACHINE
              ??= 'imx8mqevk'<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">DISTRO
              ?= 'fsl-imx-wayland'<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">PACKAGE_CLASSES
              ?= "package_rpm"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">EXTRA_IMAGE_FEATURES
              ?= "debug-tweaks"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">USER_CLASSES
              ?= "buildstats image-mklibs image-prelink"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">PATCHRESOLVE
              = "noop"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">BB_DISKMON_DIRS
              ??= "\<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              STOPTASKS,${TMPDIR},1G,100K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              STOPTASKS,${DL_DIR},1G,100K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              STOPTASKS,${SSTATE_DIR},1G,100K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              STOPTASKS,/tmp,100M,100K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              ABORT,${TMPDIR},100M,1K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              ABORT,${DL_DIR},100M,1K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              ABORT,${SSTATE_DIR},100M,1K \<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">   
              ABORT,/tmp,10M,1K"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">PACKAGECONFIG_append_pn-qemu-native
              = " sdl"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">PACKAGECONFIG_append_pn-nativesdk-qemu
              = " sdl"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">CONF_VERSION
              = "1"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p><span
                  style="text-decoration:none"> </span></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">DL_DIR
              ?= "${BSPDIR}/downloads/"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><u><span
              style="font-family:&quot;Tahoma&quot;,sans-serif">ACCEPT_FSL_EULA
              = "1"<o:p></o:p></span></u></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Tahoma&quot;,sans-serif">With the
            above configuration the files are not copied to
            sysroot/usr/include/componentincludes.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">Best
            regards,
            <br>
            <br>
            <b>Munirajulu Ugesh<br>
              RBEI/ECG-EP3<br>
            </b><br>
            Tel. +91 422 676-4710 </span><span
            style="font-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif"><br>
            <br>
          </span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:windowtext"><o:p></o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">
                Awais Belal <a class="moz-txt-link-rfc2396E" href="mailto:awais_belal@mentor.com">&lt;awais_belal@mentor.com&gt;</a>
                <br>
                <b>Sent:</b> Monday, November 26, 2018 5:22 PM<br>
                <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:kumar.ugesh003@yahoo.com">kumar.ugesh003@yahoo.com</a>; Bitbake-devel
                <a class="moz-txt-link-rfc2396E" href="mailto:bitbake-devel@lists.openembedded.org">&lt;bitbake-devel@lists.openembedded.org&gt;</a><br>
                <b>Cc:</b> Ugesh Munirajulu (RBEI/ECG-EP3)
                <a class="moz-txt-link-rfc2396E" href="mailto:Ugesh.Munirajulu@in.bosch.com">&lt;Ugesh.Munirajulu@in.bosch.com&gt;</a><br>
                <b>Subject:</b> Re: [bitbake-devel] Copying the files to
                sysroot<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">Hi
            Ugesh,</span><o:p></o:p></p>
        <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">&gt;&gt;
            1. I want to copy the header includes to
            sysroot/usr/include/component</span><o:p></o:p></p>
        <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">Simply
            install the header files to ${D}${includedir}/component at
            the end of your 1st recipe's do_install.</span><o:p></o:p></p>
        <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">e.g.</span><o:p></o:p></p>
        <p><span style="font-family:&quot;Tahoma&quot;,sans-serif">mkdir
          </span>-p ${D}${includedir}/component<o:p></o:p></p>
        <p>install -m 0644 &lt;HEADER_LOCATION&gt;/&lt;header&gt;.h
          ${D}${includedir}/component/<o:p></o:p></p>
        <p>&gt;&gt; 2. Another recipe shall be able to refer the header
          from sysroot/usr/include/component<o:p></o:p></p>
        <p>Add your 1st recipe's package name in the DEPENDS of the
          recipe where you want to utilize these headers.<o:p></o:p></p>
        <pre>BR,<o:p></o:p></pre>
        <pre>Awais<o:p></o:p></pre>
        <div>
          <p class="MsoNormal">On 26/11/18 12:36, Ugesh Reddy via
            bitbake-devel wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <div id="ymail_android_signature">
            <p class="MsoNormal">Hello All,<o:p></o:p></p>
          </div>
          <div id="yMail_cursorElementTracker_1543217671697">
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
          <div id="yMail_cursorElementTracker_1543217672288">
            <p style="margin:0in;margin-bottom:.0001pt;background:white"><span
                style="font-size:11.5pt;color:#51626F">I have the yocto
                bsp for iMx8 eval board and compiled it successfully. I
                have introduced the new custom layer and written .bb
                file for my recipe and the component is compiled
                successfully and want to install the my include in
                sysroot/usr/include/component at the end. I don't have
                the clue how to do that . Could you please some one
                guide me.<o:p></o:p></span></p>
            <p
style="margin:0in;margin-bottom:.0001pt;background:white;break-word;min-height:
              8pt">
              <span style="font-size:11.5pt;color:#51626F"> <o:p></o:p></span></p>
            <p
              style="margin:0in;margin-bottom:.0001pt;background:white;break-word"><span
                style="font-size:11.5pt;color:#51626F">I want the below
                to be achieved from .bb files.<o:p></o:p></span></p>
            <p
              style="margin:0in;margin-bottom:.0001pt;background:white;break-word"><span
                style="font-size:11.5pt;color:#51626F">1. I want to copy
                the header includes to sysroot/usr/include/component<o:p></o:p></span></p>
            <p
              style="margin:0in;margin-bottom:.0001pt;background:white;break-word"
              id="yMail_cursorElementTracker_1543217678730">
              <span style="font-size:11.5pt;color:#51626F">2. Another
                recipe shall be able to refer the header from
                sysroot/usr/include/component<o:p></o:p></span></p>
            <p
              style="margin:0in;margin-bottom:.0001pt;background:white;break-word"
              id="yMail_cursorElementTracker_1543217689960">
              <span style="font-size:11.5pt;color:#51626F"><o:p> </o:p></span></p>
            <p
              style="margin:0in;margin-bottom:.0001pt;background:white;break-word"
              id="yMail_cursorElementTracker_1543217690540">
              <span style="font-size:11.5pt;color:#51626F">Regards,<o:p></o:p></span></p>
            <p
              style="margin:0in;margin-bottom:.0001pt;background:white;break-word"
              id="yMail_cursorElementTracker_1543217696559">
              <span style="font-size:11.5pt;color:#51626F">Ugesh<o:p></o:p></span></p>
          </div>
          <p class="MsoNormal"><br>
            <br>
            <o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------F949F5A7865FF18F255AD1A9--
