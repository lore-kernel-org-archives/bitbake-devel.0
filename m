Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SrKsp-0001aX-NQ
	for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jul 2012 05:25:04 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6I3Ddrv026097
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 17 Jul 2012 20:13:39 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 17 Jul 2012 20:13:39 -0700
Message-ID: <500629E5.5000202@windriver.com>
Date: Wed, 18 Jul 2012 11:13:41 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1342495796.git.kai.kang@windriver.com>
	<97edd3e3b004e658241e3b3fc759837686deff74.1342495796.git.kai.kang@windriver.com>
	<1342518777.10484.2.camel@ted>
In-Reply-To: <1342518777.10484.2.camel@ted>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q6I3Ddrv026097
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
X-List-Received-Date: Wed, 18 Jul 2012 03:25:04 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B407=E6=9C=8817=E6=97=A5 17:52, Richard Purdie wrote:
> On Tue, 2012-07-17 at 14:58 +0800, Kang Kai wrote:
>> [Yocto #2709]
>>
>> OE Core Commit c9b01af84b64edba056f959c349895e0698324e6 add elf image
>> type. This will cause hob build image failed.
>> Add elf to hcc supoorted image types to fix this issue.
>>
>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>> ---
>>   bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui=
/crumbs/hobwidget.py
>> index dba278c..d10c56b 100644
>> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
>> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
>> @@ -89,6 +89,7 @@ class hcc:
>>           "cpio.xz"       : ["cpio.xz"],
>>           "vmdk"          : ["vmdk"],
>>           "cpio.lzma"     : ["cpio.lzma"],
>> +        "elf"           : ["elf"],
>>       }
>>
>>   class HobViewTable (gtk.VBox):

Hi Richard,

Thanks.

> Why do we have a hardcoded list here and why do new image types cause
> builds to fail?
After build the image, Hob trys to get list of created images. It needs=20
a map from image type to real image file's extend name, such as "live"=20
--> "hddimg" and "iso".
then search the image output dir to get the list.
>
> We need to rewrite this code so this does not happen and the user at
> least gets a sensible error message. Hardcoded lists are bad...

For the current, only image type 'live' need this map. So I can remove=20
the list and check the image type is whether 'live' or not.
But for the future, if a new image type added and need this kind of map,=20
new check for the single type is needed. I think for this scenario the=20
list is better.

Regards,
Kai

>
> I've merged the patch but I'd like to see a bug opened about this.
>
> Cheers,
>
> Richard
>
>



