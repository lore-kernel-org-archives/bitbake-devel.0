Return-Path: <yocto@mindchasers.com>
X-Greylist: delayed 1223 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 19 Nov 2014 03:22:20 UTC
Received: from smtp.webfaction.com (mail6.webfaction.com [74.55.86.74])
	by mail.openembedded.org (Postfix) with ESMTP id E398872041
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Nov 2014 03:22:20 +0000 (UTC)
Received: from [192.168.1.10] (unknown [68.38.40.177])
	by smtp.webfaction.com (Postfix) with ESMTP id CCD03207CC72;
	Wed, 19 Nov 2014 03:01:56 +0000 (UTC)
Message-ID: <546C0823.6060808@mindchasers.com>
Date: Tue, 18 Nov 2014 22:01:55 -0500
From: Bob Cochran <yocto@mindchasers.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>, 
	Yocto discussion list <yocto@yoctoproject.org>
References: <545FD907.2070003@mindchasers.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237988E52758@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB1237988E52758@ORSMSX101.amr.corp.intel.com>
X-Mailman-Approved-At: Sun, 23 Nov 2014 21:58:57 +0000
Cc: paul@paulbarker.me.uk, bitbake-dev <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] newbb.vim vs skeleton recipe in yocto-docs dev manual....
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
X-List-Received-Date: Wed, 19 Nov 2014 03:22:28 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2014 09:28 AM, Rifenbark, Scott M wrote:
> newbb.vim needs to be patched.


I have a patch ready to bring newbb.vim in line with Section 5.3.2 of 
the Yocto Project Dev Manual.   However, I'm wondering whether I can 
drop the initial two lines of the generated file (I think I should):


# Copyright (C) 2014 <user_name> <user_email>
# Released under the MIT license (see COPYING.MIT for the terms)


This seems inconsistent with the recipes I see in the Yocto / OE layers 
and the Yocto documentation.

The patch I created, which is provided below for reference, comments out 
the generation of these first two lines:


--- a/bitbake/contrib/vim/plugin/newbb.vim
+++ b/bitbake/contrib/vim/plugin/newbb.vim
@@ -44,21 +44,31 @@ fun! NewBBTemplate()
      let l:paste = &paste
      set nopaste

-    " Get the header
-    call BBHeader()
+    " Uncomment the line below to enable header generation
+    "call BBHeader()

      " New the bb template
+    0 put ='SUMMARY = \"\"'
      put ='DESCRIPTION = \"\"'
      put ='HOMEPAGE = \"\"'
      put ='LICENSE = \"\"'
-    put ='SECTION = \"\"'
+    put ='LIC_FILES_CHKSUM = \"\"'
+    put =''
      put ='DEPENDS = \"\"'
      put =''
      put ='SRC_URI = \"\"'
+    put ='SRC_URI[md5sum] = \"\"'
+    put ='SRC_URI[sha256sum] = \"\"'
+    put =''
+    put ='S = \"${WORKDIR}/${PN}-${PV}\"'
+    put =''
+    put ='#inherit <classes>'
+
+

      " Go to the first place to edit
      0
-    /^DESCRIPTION =/
+    /^SUMMARY =/
      exec "normal 2f\""

      if paste == 1



thanks

Bob




>
> Scott
>
>> -----Original Message-----
>> From: yocto-bounces@yoctoproject.org [mailto:yocto-
>> bounces@yoctoproject.org] On Behalf Of Bob Cochran
>> Sent: Sunday, November 09, 2014 1:14 PM
>> To: Yocto discussion list
>> Subject: [yocto] newbb.vim vs skeleton recipe in yocto-docs dev manual....
>>
>> Hi,
>>
>> I just noticed that newbb.vim in bitbake/contrib is notably different from the
>> skeleton recipe proposed in the latest Dev Manual.
>>
>> I'll submit a patch if someone can give me some guidance on what should be
>> in newbb.vim (or maybe it's the manual that needs to be patched).
>>
>> Bob
>>
>>
>>  From yocto-docs: Dev Manual (modify the following skeleton recipe):
>>
>> SUMMARY = ""
>> HOMEPAGE = ""
>> LICENSE = ""
>> LIC_FILES_CHKSUM = ""
>> SRC_URI = ""
>> SRC_URI[md5sum] = ""
>> SRC_URI[sha256sum] = ""
>> S = "${WORKDIR}/${PN}-${PV}"
>>
>>
>>
>>  From newbb.vim:
>>
>> DESCRIPTION = ""
>> HOMEPAGE = ""
>> LICENSE = ""
>> SECTION = ""
>> DEPENDS = ""
>>
>> SRC_URI = ""
>>
>>
>> --
>> _______________________________________________
>> yocto mailing list
>> yocto@yoctoproject.org
>> https://lists.yoctoproject.org/listinfo/yocto
>


