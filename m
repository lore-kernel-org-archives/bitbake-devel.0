Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T5ouj-0001Ib-II
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Aug 2012 04:18:53 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7R26djk028097
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 26 Aug 2012 19:06:39 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Sun, 26 Aug 2012 19:06:39 -0700
Message-ID: <503AD63C.8030703@windriver.com>
Date: Mon, 27 Aug 2012 10:06:52 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1345799414.git.kai.kang@windriver.com>
	<b081443c18a09548804fe39eb718355e0f067ff5.1345799414.git.kai.kang@windriver.com>
	<1345880741.14369.95.camel@ted>
In-Reply-To: <1345880741.14369.95.camel@ted>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q7R26djk028097
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 3/3] bitbake.conf: add variable IMAGE_TYPES_MAP
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
X-List-Received-Date: Mon, 27 Aug 2012 02:18:54 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B408=E6=9C=8825=E6=97=A5 15:45, Richard Purdie wrote:
> On Fri, 2012-08-24 at 17:15 +0800, Kang Kai wrote:
>> Add variable IMAGE_TYPES_MAP to replace the hob2 hard-coded image type=
s
>> map.
>>
>> The format of IMAGE_TYPES_MAP is:
>> "image_type1:realname_extend1 image_type2:realname_extend2,extend3 ...=
"
>>
>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>> ---
>>   meta/conf/bitbake.conf |    3 +++
>>   1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
>> index ad98756..7d2a9b9 100644
>> --- a/meta/conf/bitbake.conf
>> +++ b/meta/conf/bitbake.conf
>> @@ -770,3 +770,6 @@ BB_SIGNATURE_EXCLUDE_FLAGS ?=3D "doc defaultval _a=
ppend _prepend deps depends lock
>>
>>   MLPREFIX ??=3D ""
>>   MULTILIB_VARIANTS ??=3D ""
>> +
>> +# Used by to Hob to filter image files
>> +IMAGE_TYPES_MAP =3D "btrfs:btrfs cpio.gz:cpio.gz cpio.lzma:cpio.lzma =
cpio.xz:cpio.xz cpio:cpio cramfs:cramfs elf:elf ext2.bz2:ext2.bz2 ext2.gz=
:ext2.gz ext2.lzma:ext2.lzma ext2:ext2 ext3.gz:ext3.gz ext3:ext3 jffs2:jf=
fs2 live:hddimg,iso squashfs-lzma:squashfs-lzma squashfs:squashfs sum.jff=
s2:sum.jffs2 tar.bz2:tar.bz2 tar.gz:tar.gz tar.xz:tar.xz tar:tar ubi:ubi =
vmdk:vmdk"

Hi Richard,

> I think this still overcomplicates things. Firstly, can't we assume the
> names map 1:1 with some exceptions.
>
> For the exceptions, lets just add something like:
>
> IMAGE_EXTENSION_live =3D "hddimg iso"
>
> to image_types.bbclass (or image-live.bbclass)
>
> and then the UI can query that variable name and assume a 1:1 mapping i=
f
> its not present.
Thanks a lot.
I'll update it.

Regards,
Kai

>
> Cheers,
>
> Richard
>
>



