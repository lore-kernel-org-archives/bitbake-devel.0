Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1S87DE-0007U9-LN
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 10:43:13 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q2F9YLw5014379
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 15 Mar 2012 02:34:21 -0700 (PDT)
Received: from [128.224.162.241] (128.224.162.241) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Thu, 15 Mar 2012 02:34:21 -0700
Message-ID: <4F61B79D.8000405@windriver.com>
Date: Thu, 15 Mar 2012 17:34:21 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Martin Jansa <martin.jansa@gmail.com>
References: <4F605E85.7070904@windriver.com> <1331718176.18586.15.camel@ted>
	<4F61926D.1060709@windriver.com> <4F619CD4.4090103@windriver.com>
	<20120315080310.GC4973@jama.jama.net>
	<4F61B1D0.2080306@windriver.com>
	<20120315092122.GE4973@jama.jama.net>
In-Reply-To: <20120315092122.GE4973@jama.jama.net>
X-Originating-IP: [128.224.162.241]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail1.windriver.com id
	q2F9YLw5014379
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
X-List-Received-Date: Thu, 15 Mar 2012 09:43:13 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 17:21, Martin Jansa wrote:
> On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:
>> On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 16:03, Martin Jansa wrote:
>>> On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
>>>> On 2012=E5=B9=B403=E6=9C=8815=E6=97=A5 14:55, Kang Kai wrote:
>>>>> On 2012=E5=B9=B403=E6=9C=8814=E6=97=A5 17:42, Richard Purdie wrote:
>>>>>> On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> I write a script to clean up WORKDIR that remove the obsoleted
>>>>>>> packages' build directories.
>>>>>>> The script accept a argument as BUILDDIR and I use this clause to
>>>>>>> identify the WORKDIR:
>>>>>>>
>>>>>>>         workdir =3D os.path.join(builddir, 'tmp/work')
>>>>>>>
>>>>>>> Then validate the workdir exists or not. It works for me but hard=
code
>>>>>>> here as Richard point out.
>>>>>>> So is there  a better way to get the WORKDIR here? Thanks.
>>>>>> I was thinking of something like:
>>>>>>
>>>>>> bitbake -e | grep ^WORKDIR
>>>> And the result is something like that:
>>>> WORKDIR=3D"/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x8=
6_64-poky-linux/bblayers-1.0-r0"
>>>>
>>>> Is it ok to remove 2 items seperated by slash at the end of string?
>>>> Right now is:
>>>> "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"
>>> Aren't you looking for ^TMPDIR ?
>> If use WORKDIR =3D TMPDIR/"work", it is still hard coding.
> Assuming 2 items at the end won't work for people using rm_old_work:
> http://git.openembedded.org/meta-micro/commit/?id=3Dfcf525654915edb9650=
f1a6c2852f336366f8b2f
> or slightly different version:
> http://git.shr-project.org/git/?p=3Dmeta-smartphone.git;a=3Dblob;f=3Dme=
ta-shr/classes/rm_old_work.bbclass

Hi Martin,
> And I think more people have different "tmp/" part e.g. default would b=
e
> "tmp-eglibc/" (thanks to TCLIBCAPPEND
> meta/conf/distro/defaultsetup.conf:TMPDIR .=3D "${TCLIBCAPPEND}"), but =
"work" is
> quite common.
>
> meta/conf/bitbake.conf:
> WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
> meta-shr/classes/rm_old_work.bbclass:
> WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${PF}"
> meta-micro/classes/rm_old_work.bbclass:
> WORKDIR =3D "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${=
PV}-${PR}"

OK. Thanks very much.

Regards,
Kai

> Cheers,
>
>>>> Regards,
>>>> Kai
>>>>
>>>>> If get WORKDIR in this way, I'll update the script with no argument
>>>>> because the argument is useless to identify the WORKDIR.
>>>>>
>>>>> Regards,
>>>>> Kai
>>>>>> since you already call into bitbake in the script in question.
>>>>>>
>>>>>> Cheers,
>>>>>>
>>>>>> Richard
>>>>>>
>>>>>>
>>>>> _______________________________________________
>>>>> bitbake-devel mailing list
>>>>> bitbake-devel@lists.openembedded.org
>>>>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>>>> _______________________________________________
>>>> bitbake-devel mailing list
>>>> bitbake-devel@lists.openembedded.org
>>>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



