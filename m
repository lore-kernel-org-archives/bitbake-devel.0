Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Ty2zQ-0005ad-GJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 17:15:56 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r0NCDumE013460
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 23 Jan 2013 04:13:57 -0800 (PST)
Received: from [172.25.32.40] (172.25.32.40) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Wed, 23 Jan 2013 04:13:56 -0800
Message-ID: <50FFD403.8070001@windriver.com>
Date: Wed, 23 Jan 2013 06:13:55 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: Trung Hoang <trungiee@gmail.com>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
	<CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
	<50FEC2BE.3020902@windriver.com>
	<2ABB9CD2-9E60-4E5A-A9B0-1C96F25A424B@gmail.com>
In-Reply-To: <2ABB9CD2-9E60-4E5A-A9B0-1C96F25A424B@gmail.com>
X-Enigmail-Version: 1.5
X-MIME-Autoconverted: from 8bit to quoted-printable by mail1.windriver.com id
	r0NCDumE013460
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Display mode
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
X-List-Received-Date: Wed, 23 Jan 2013 16:15:56 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01/22/2013 04:21 PM, Trung Hoang wrote:
> Ahh yes, Knotty2 rocks!=20
>
> For those who don't get this by default, i did this..=20
>
> `bitbake -u knotty2 gumstix-console-image'=20
>
> I do notice that sometimes the "Running task 3160 of 3162 =85" does get=
 buggy.. Instead of updating that line it makes a new line so i end up wi=
th=85=20
>
> Running task 3160 of 3162..
> Running task 3161 of 3162..
> Running task 3162 of 3162=85
> 0: =85


I submitted a pile of fixes to knotty2 around the time it was made the de=
fault to fix this problem and a number of others (such as resizing your t=
erminal window while building).  The particular problem you see is caused=
 by not reading the terminal size and computing when lines are going to w=
rap.   If you are seeing this behavior with the bitbake master branch ple=
ase send a report.

Jason.


