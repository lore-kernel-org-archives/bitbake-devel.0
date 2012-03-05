Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1S4NrD-000699-1B
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Mar 2012 03:41:03 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q252WMIY025326
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 4 Mar 2012 18:32:23 -0800 (PST)
Received: from [128.224.162.241] (128.224.162.241) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Sun, 4 Mar 2012 18:32:22 -0800
Message-ID: <4F542552.5090304@windriver.com>
Date: Mon, 5 Mar 2012 10:30:42 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1330674604.git.kai.kang@windriver.com>
	<bbac4fa41e627a8673202459461c10e0c1426b61.1330674604.git.kai.kang@windriver.com>
	<CABcZANmgbf_fDAxsqOkzzNX2t81u2tkeGsgibgo3nDyQzA1vng@mail.gmail.com>
	<1330706188.309.15.camel@ted>
In-Reply-To: <1330706188.309.15.camel@ted>
X-Originating-IP: [128.224.162.241]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q252WMIY025326
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: enable cleanup of WORKDIR
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
X-List-Received-Date: Mon, 05 Mar 2012 02:41:03 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B403=E6=9C=8803=E6=97=A5 00:36, Richard Purdie wrote:
> On Fri, 2012-03-02 at 08:33 -0700, Chris Larson wrote:
>> On Fri, Mar 2, 2012 at 12:54 AM, Kang Kai<kai.kang@windriver.com>  wro=
te:
>>> [Yocto 1561]
>>> Add a command line option for bitbake to enable cleanup of WORKDIR.
>>> It checks every package build directories under WORKDIR then parse
>>> the directory name to get package name and version. If the version
>>> is not the package prefer version then delete the directory.
>>>
>>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>>> ---
>>>   bitbake/bin/bitbake       |    4 +++
>>>   bitbake/lib/bb/command.py |    5 +++
>>>   bitbake/lib/bb/cooker.py  |   63 ++++++++++++++++++++++++++++++++++=
+++++++++++
>>>   3 files changed, 72 insertions(+), 0 deletions(-)
>> This is wrong on multiple levels. bitbake (other than some hacky stuff
>> in the fetcher that needs to die) has *zero* knowledge of the use of
>> WORKDIR today, that's entirely metadata implementation.
> Totally agreed. I saw a comment earlier today in the bugzilla about thi=
s
> and made the same comment even before I saw this patch...
OK. I'll do it in another way.

Regards,
Kai
>
> Cheers,
>
> Richard
>



