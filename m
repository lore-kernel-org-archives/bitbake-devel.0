Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9ACF2788EB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Jul 2018 10:57:01 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w62Av0Y3006155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Mon, 2 Jul 2018 11:57:02 +0100
Message-ID: <241c1a75e52fc5e8b88218f15ba5eb6a0c28eac8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jef.Driesen@niko.eu, bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jul 2018 11:57:00 +0100
In-Reply-To: <FAB9E48578194042BE5C63B8BE47610339DDDBB4@MBX.NIKO.LAN>
References: <FAB9E48578194042BE5C63B8BE47610339DD77AC@MBX.NIKO.LAN>
	<5a7291cc2b09594f618088148ea31d18354f157a.camel@linuxfoundation.org>
	<FAB9E48578194042BE5C63B8BE47610339DDDBB4@MBX.NIKO.LAN>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: pseudo interfering with git fetcher?
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
X-List-Received-Date: Mon, 02 Jul 2018 10:57:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-07-02 at 10:15 +0000, Jef.Driesen@niko.eu wrote:
> On 07/02/2018 11:33 AM, Richard Purdie wrote:
> > On Mon, 2018-07-02 at 07:04 +0000, Jef.Driesen@niko.eu wrote:
> > > I'm occasionally experiencing problems when fetching code from
> > > git
> > > repositories over ssh. The error is always this one:
> > 
> > Which version of bitbake are you using?
> > 
> > I think this change may help you:
> > 
> > http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake?id=205cfd7
> > 02190026e64eed9cae27c05ff62d1637e
> 
> We are using pyro (and about to upgrade to rocko). But it looks like
> that commit is only available in later versions (sumo).

It should cherry-pick easily enough but I just backported it to
rocko/pyro since we should fix this there and be consistent.

Cheers,

Richard

