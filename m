Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CE6856C2E6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2018 15:59:40 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	wAGFxc0U014087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 16 Nov 2018 15:59:39 GMT
Message-ID: <8e3216253e9039ecd30c30f5ce5aeef7e7486480.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ilya Kondrashkin <kondrashkin.ilya@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 16 Nov 2018 15:59:38 +0000
In-Reply-To: <5bed885e.1c69fb81.2f7c6.980e@mx.google.com>
References: <5bed885e.1c69fb81.2f7c6.980e@mx.google.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.2 at dan
X-Virus-Status: Clean
Subject: Re: LAYERSERIES_CORENAMES empty
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
X-List-Received-Date: Fri, 16 Nov 2018 15:59:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-11-15 at 17:53 +0300, Ilya Kondrashkin wrote:
> Hi folks,
> 
> Currently I’m experiencing issue with LAYERSERIES_COMPAT variable.
> I have “sumo” revision of poky and layer with LAYERSERIES_COMPAT set
> to “rocko sumo”. Every bitbake call gets failed due to layer
> incompatibility.
>  
> After adding some debug lines to bitbake/lib/bb/cookerdata.py I found
> out that LAYERSERIES_CORENAMES is empty. Checked layer.conf of
> poky/meta - LAYERSERIES_CORENAMES is set to “core”.

In master and the thud branch it appears to be set to "thud", are you
sure its set to "core"? That doesn't make much sense.

> Did you see such issue before? Is there any known solution to escape
> from this? I cannot find any references over the internet.

I suspect we changed to the new series and your layer isn't marked as
compatible. Why you're not getting a sensible error message saying that
I'm not sure though.

Cheers,

Richard


