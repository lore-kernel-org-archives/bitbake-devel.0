Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 80ADB7876D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Jul 2018 09:33:10 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w629X94E029373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Mon, 2 Jul 2018 10:33:10 +0100
Message-ID: <5a7291cc2b09594f618088148ea31d18354f157a.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jef.Driesen@niko.eu, bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jul 2018 10:33:09 +0100
In-Reply-To: <FAB9E48578194042BE5C63B8BE47610339DD77AC@MBX.NIKO.LAN>
References: <FAB9E48578194042BE5C63B8BE47610339DD77AC@MBX.NIKO.LAN>
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
X-List-Received-Date: Mon, 02 Jul 2018 09:33:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-07-02 at 07:04 +0000, Jef.Driesen@niko.eu wrote:
> I'm occasionally experiencing problems when fetching code from git
> repositories over ssh. The error is always this one:

Which version of bitbake are you using?

I think this change may help you:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake?id=205cfd702190026e64eed9cae27c05ff62d1637e

Cheers,

Richard

