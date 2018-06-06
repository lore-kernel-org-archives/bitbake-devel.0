Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 464127713E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 22:00:16 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w56M0Fhu002878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 6 Jun 2018 23:00:16 +0100
Message-ID: <dc02f233a4a9b661e1de3eee4d8faba53ccb8d9a.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 06 Jun 2018 23:00:15 +0100
In-Reply-To: <CAJ86T=U2s_uFMpc4ZwicFaixqfHo5ABMyKbbrU4XKtHV6-gwMQ@mail.gmail.com>
References: <CAJ86T=U2s_uFMpc4ZwicFaixqfHo5ABMyKbbrU4XKtHV6-gwMQ@mail.gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: expand after getVar
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
X-List-Received-Date: Wed, 06 Jun 2018 22:00:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-06-06 at 14:53 -0700, Andre McCurdy wrote:
> Is the following expression from trusted_network():
> 
>   d.expand(d.getVar('PN', False))
> 
> completely equivalent to:
> 
>   d.getVar('PN")
> 
> or is there something subtle going on?

It should be equivalent.

Cheers,

Richard

