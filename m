Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1S85Qb-0004i6-HY
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 08:48:53 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q2F7e4HA013336
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 15 Mar 2012 00:40:04 -0700 (PDT)
Received: from [128.224.162.241] (128.224.162.241) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Thu, 15 Mar 2012 00:40:04 -0700
Message-ID: <4F619CD4.4090103@windriver.com>
Date: Thu, 15 Mar 2012 15:40:04 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <4F605E85.7070904@windriver.com> <1331718176.18586.15.camel@ted>
	<4F61926D.1060709@windriver.com>
In-Reply-To: <4F61926D.1060709@windriver.com>
X-Originating-IP: [128.224.162.241]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail1.windriver.com id
	q2F7e4HA013336
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: How to identify WORKDIR?
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
X-List-Received-Date: Thu, 15 Mar 2012 07:48:54 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 14:55, Kang Kai wrote:
> On 2012=E5=B9=B403=E6=9C=8814=E6=97=A5 17:42, Richard Purdie wrote:
>> On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
>>> Hi All,
>>>
>>> I write a script to clean up WORKDIR that remove the obsoleted
>>> packages' build directories.
>>> The script accept a argument as BUILDDIR and I use this clause to
>>> identify the WORKDIR:
>>>
>>>       workdir =3D os.path.join(builddir, 'tmp/work')
>>>
>>> Then validate the workdir exists or not. It works for me but hardcode
>>> here as Richard point out.
>>> So is there  a better way to get the WORKDIR here? Thanks.
>> I was thinking of something like:
>>
>> bitbake -e | grep ^WORKDIR
And the result is something like that:
WORKDIR=3D"/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x86_64-=
poky-linux/bblayers-1.0-r0"

Is it ok to remove 2 items seperated by slash at the end of string?=20
Right now is:
"/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"

Regards,
Kai

>
> If get WORKDIR in this way, I'll update the script with no argument=20
> because the argument is useless to identify the WORKDIR.
>
> Regards,
> Kai
>>
>> since you already call into bitbake in the script in question.
>>
>> Cheers,
>>
>> Richard
>>
>>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



