Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id ED2826C474
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Nov 2018 11:52:15 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gRFR1-0004EL-Iq from Awais_Belal@mentor.com ;
	Mon, 26 Nov 2018 03:52:15 -0800
Received: from [137.202.156.92] (137.202.0.90) by
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Mon, 26 Nov 2018 11:52:11 +0000
To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>, Bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <119490492.5831423.1543217793985.ref@mail.yahoo.com>
	<119490492.5831423.1543217793985@mail.yahoo.com>
From: Awais Belal <awais_belal@mentor.com>
Message-ID: <5a9fde61-7134-2abf-4eae-18bb9ba4b8cb@mentor.com>
Date: Mon, 26 Nov 2018 16:52:10 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <119490492.5831423.1543217793985@mail.yahoo.com>
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Cc: "Ugesh Munirajulu \(RBEI\\/ECG-EP3\)" <ugesh.munirajulu@in.bosch.com>
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
X-List-Received-Date: Mon, 26 Nov 2018 11:52:16 -0000
Content-Type: multipart/alternative;
	boundary="------------6BE6DCAC21171A55395E2502"
Content-Language: en-US

--------------6BE6DCAC21171A55395E2502
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ugesh,

 >> 1. I want to copy the header includes to sysroot/usr/include/component

Simply install the header files to ${D}${includedir}/component at the 
end of your 1st recipe's do_install.

e.g.

mkdir -p ${D}${includedir}/component

install -m 0644 <HEADER_LOCATION>/<header>.h ${D}${includedir}/component/

 >> 2. Another recipe shall be able to refer the header from 
sysroot/usr/include/component

Add your 1st recipe's package name in the DEPENDS of the recipe where 
you want to utilize these headers.

BR,
Awais

On 26/11/18 12:36, Ugesh Reddy via bitbake-devel wrote:
> Hello All,
>
> I have the yocto bsp for iMx8 eval board and compiled it successfully. 
> I have introduced the new custom layer and written .bb file for my 
> recipe and the component is compiled successfully and want to install 
> the my include in sysroot/usr/include/component at the end. I don't 
> have the clue how to do that . Could you please some one guide me.
>
> I want the below to be achieved from .bb files.
>
> 1. I want to copy the header includes to sysroot/usr/include/component
>
> 2. Another recipe shall be able to refer the header from 
> sysroot/usr/include/component
>
>
> Regards,
>
> Ugesh
>
>
>


--------------6BE6DCAC21171A55395E2502
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><font face="Tahoma">Hi Ugesh,</font></p>
    <p><font face="Tahoma">&gt;&gt; 1. I want to copy the header
        includes to sysroot/usr/include/component</font></p>
    <p><font face="Tahoma">Simply install the header files to
        ${D}${includedir}/component at the end of your 1st recipe's
        do_install.</font></p>
    <p><font face="Tahoma">e.g.</font></p>
    <p><font face="Tahoma">mkdir </font>-p ${D}${includedir}/component</p>
    <p>install -m 0644 &lt;HEADER_LOCATION&gt;/&lt;header&gt;.h
      ${D}${includedir}/component/</p>
    <p>&gt;&gt; 2. Another recipe shall be able to refer the header from
      sysroot/usr/include/component</p>
    <p>Add your 1st recipe's package name in the DEPENDS of the recipe
      where you want to utilize these headers.<br>
    </p>
    <pre class="moz-signature" cols="72">BR,
Awais</pre>
    <div class="moz-cite-prefix">On 26/11/18 12:36, Ugesh Reddy via
      bitbake-devel wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:119490492.5831423.1543217793985@mail.yahoo.com">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div id="ymail_android_signature">Hello All,</div>
      <div id="yMail_cursorElementTracker_1543217671697"><br>
      </div>
      <div id="yMail_cursorElementTracker_1543217672288">
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);"
          id="yMail_cursorElementTracker_1543217680825">I have the yocto
          bsp for iMx8 eval board and compiled it successfully. I have
          introduced the new custom layer and written .bb file for my
          recipe and the component is compiled successfully and want to
          install the my include in sysroot/usr/include/component at the
          end. I don't have the clue how to do that . Could you please
          some one guide me.</p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255); min-height: 8pt;"> </p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);">I want the below to be
          achieved from .bb files.</p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);">1. I want to copy the
          header includes to sysroot/usr/include/component</p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);"
          id="yMail_cursorElementTracker_1543217678730">2. Another
          recipe shall be able to refer the header from
          sysroot/usr/include/component</p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);"
          id="yMail_cursorElementTracker_1543217689960"><br>
        </p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);"
          id="yMail_cursorElementTracker_1543217690540">Regards,</p>
        <p style="margin: 0px; padding: 0px; border: 0px; font-size:
          15px; font-family: arial, helvetica, &quot;helvetica
          neue&quot;, verdana, sans-serif; vertical-align: baseline;
          overflow-wrap: break-word; color: rgb(81, 98, 111);
          background-color: rgb(255, 255, 255);"
          id="yMail_cursorElementTracker_1543217696559">Ugesh</p>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------6BE6DCAC21171A55395E2502--
