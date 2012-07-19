Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SrhOq-0007IG-4o
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jul 2012 05:27:36 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6J3GB7e028996
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 18 Jul 2012 20:16:11 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Wed, 18 Jul 2012 20:16:10 -0700
Message-ID: <50077BFE.7010104@windriver.com>
Date: Thu, 19 Jul 2012 11:16:14 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1342495796.git.kai.kang@windriver.com>
	<97edd3e3b004e658241e3b3fc759837686deff74.1342495796.git.kai.kang@windriver.com>
	<1342518777.10484.2.camel@ted> <500629E5.5000202@windriver.com>
	<1342617314.30680.29.camel@ted>
In-Reply-To: <1342617314.30680.29.camel@ted>
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] hob2: add elf to hcc supported image types
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 19 Jul 2012 03:27:36 -0000
Content-Type: multipart/alternative;
	boundary="------------020107030905060109040804"

--------------020107030905060109040804
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id q6J3GB7e028996

On 2012=E5=B9=B407=E6=9C=8818=E6=97=A5 21:15, Richard Purdie wrote:
> On Wed, 2012-07-18 at 11:13 +0800, Kang Kai wrote:
>> On 2012=E5=B9=B407=E6=9C=8817=E6=97=A5 17:52, Richard Purdie wrote:
>>> On Tue, 2012-07-17 at 14:58 +0800, Kang Kai wrote:
>>>> [Yocto #2709]
>>>>
>>>> OE Core Commit c9b01af84b64edba056f959c349895e0698324e6 add elf imag=
e
>>>> type. This will cause hob build image failed.
>>>> Add elf to hcc supoorted image types to fix this issue.
>>>>
>>>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>>>> ---
>>>>    bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
>>>>    1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/=
ui/crumbs/hobwidget.py
>>>> index dba278c..d10c56b 100644
>>>> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
>>>> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
>>>> @@ -89,6 +89,7 @@ class hcc:
>>>>            "cpio.xz"       : ["cpio.xz"],
>>>>            "vmdk"          : ["vmdk"],
>>>>            "cpio.lzma"     : ["cpio.lzma"],
>>>> +        "elf"           : ["elf"],
>>>>        }
>>>>
>>>>    class HobViewTable (gtk.VBox):
>> Hi Richard,
>>
>> Thanks.
>>
>>> Why do we have a hardcoded list here and why do new image types cause
>>> builds to fail?
>> After build the image, Hob trys to get list of created images. It need=
s
>> a map from image type to real image file's extend name, such as "live"
>> -->  "hddimg" and "iso".
>> then search the image output dir to get the list.
>>> We need to rewrite this code so this does not happen and the user at
>>> least gets a sensible error message. Hardcoded lists are bad...
>> For the current, only image type 'live' need this map. So I can remove
>> the list and check the image type is whether 'live' or not.
>> But for the future, if a new image type added and need this kind of ma=
p,
>> new check for the single type is needed. I think for this scenario the
>> list is better.

Hi Richard,

> Well, I *hate* the concept that if you add a new image type, the UI has
> to be changed.
>
> Ideally, we need to add something to the metadata that explains this
> mapping to the UI. I want to see the hardcoded list removed from the UI=
,
> one way or another.
I create *Bug 2795*=20
<https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D2795> to follow this=
=20
issue, and 2709 is closed suggested by Jessica.

Regards,
Kai
<mailto:jessica.zhang@intel.com>
>
> Cheers,
>
> Richard
>
>


--------------020107030905060109040804
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id q6J3GB7e028996

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    On 2012=E5=B9=B407=E6=9C=8818=E6=97=A5 21:15, Richard Purdie wrote:
    <blockquote cite=3D"mid:1342617314.30680.29.camel@ted" type=3D"cite">
      <pre wrap=3D"">On Wed, 2012-07-18 at 11:13 +0800, Kang Kai wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">On 2012=E5=B9=B407=E6=9C=8817=E6=97=A5 17:52, Rich=
ard Purdie wrote:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">On Tue, 2012-07-17 at 14:58 +0800, Kang Kai wrot=
e:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"">[Yocto #2709]

OE Core Commit c9b01af84b64edba056f959c349895e0698324e6 add elf image
type. This will cause hob build image failed.
Add elf to hcc supoorted image types to fix this issue.

Signed-off-by: Kang Kai<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
kai.kang@windriver.com">&lt;kai.kang@windriver.com&gt;</a>
---
  bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/cr=
umbs/hobwidget.py
index dba278c..d10c56b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -89,6 +89,7 @@ class hcc:
          "cpio.xz"       : ["cpio.xz"],
          "vmdk"          : ["vmdk"],
          "cpio.lzma"     : ["cpio.lzma"],
+        "elf"           : ["elf"],
      }

  class HobViewTable (gtk.VBox):
</pre>
          </blockquote>
        </blockquote>
        <pre wrap=3D"">
Hi Richard,

Thanks.

</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">Why do we have a hardcoded list here and why do =
new image types cause
builds to fail?
</pre>
        </blockquote>
        <pre wrap=3D"">After build the image, Hob trys to get list of cre=
ated images. It needs=20
a map from image type to real image file's extend name, such as "live"=20
--&gt; "hddimg" and "iso".
then search the image output dir to get the list.
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">
We need to rewrite this code so this does not happen and the user at
least gets a sensible error message. Hardcoded lists are bad...
</pre>
        </blockquote>
        <pre wrap=3D"">
For the current, only image type 'live' need this map. So I can remove=20
the list and check the image type is whether 'live' or not.
But for the future, if a new image type added and need this kind of map,=20
new check for the single type is needed. I think for this scenario the=20
list is better.
</pre>
      </blockquote>
    </blockquote>
    <br>
    Hi Richard,<br>
    <br>
    <blockquote cite=3D"mid:1342617314.30680.29.camel@ted" type=3D"cite">
      <pre wrap=3D"">
Well, I *hate* the concept that if you add a new image type, the UI has
to be changed.

Ideally, we need to add something to the metadata that explains this
mapping to the UI. I want to see the hardcoded list removed from the UI,
one way or another.</pre>
    </blockquote>
    I create <a
      href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D2795"><=
b>Bug=C2=A02795</b></a>
    to follow this issue, and 2709 is closed suggested by Jessica.<br>
    <br>
    Regards,<br>
    Kai<br>
    <span class=3D"bz_comment_user"><span class=3D"vcard"><a class=3D"ema=
il"
          href=3D"mailto:jessica.zhang@intel.com" title=3D"Jessica
          &lt;jessica.zhang@intel.com&gt;"><span class=3D"fn"></span></a>
      </span></span>
    <blockquote cite=3D"mid:1342617314.30680.29.camel@ted" type=3D"cite">
      <pre wrap=3D"">

Cheers,

Richard


</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020107030905060109040804--
