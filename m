Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1U9T7t-0003sb-PE
	for bitbake-devel@lists.openembedded.org;
	Sun, 24 Feb 2013 05:23:56 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r1O0miwW009614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sat, 23 Feb 2013 16:48:44 -0800 (PST)
Received: from [172.25.32.35] (172.25.32.35) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.342.3;
	Sat, 23 Feb 2013 16:48:43 -0800
Message-ID: <5129636A.1070706@windriver.com>
Date: Sat, 23 Feb 2013 18:48:42 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>
References: <CALbNGRSGHYF0-9AgF7KmK8W_BBBOriVmx7FYupxySHUgdqKeYg@mail.gmail.com>
In-Reply-To: <CALbNGRSGHYF0-9AgF7KmK8W_BBBOriVmx7FYupxySHUgdqKeYg@mail.gmail.com>
X-Enigmail-Version: 1.5
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	r1O0miwW009614
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: parse does not cache
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
X-List-Received-Date: Sun, 24 Feb 2013 04:23:56 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/23/2013 03:44 PM, Andreas M=FCller wrote:
> Hi,
>
> with the latest HEAD bitbake performs a full parse for every run. I
> could not find a hint so far - so is it a bug or did I miss something?

It depends on what OE you are using.  If you don't have the changes for t=
he BB_ORIGENV introduced by commit 0a99563a4ea270594fd9a61da46f9387fb79dc=
66 you will find that things definitely always parse every single time.

You can always try reverting that single commit to see if the behavior ch=
anges.  There are also other changes like that with in the bitbake histor=
y where it does not always work with older versions of OE.

Cheers,
Jason.


