Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S5ezj-0002Iz-R5 for bitbake-devel@lists.openembedded.org;
	Thu, 08 Mar 2012 16:11:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q28F2QEE009548;
	Thu, 8 Mar 2012 15:02:26 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09122-05; Thu,  8 Mar 2012 15:02:17 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q28F1xXF009348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Mar 2012 15:02:03 GMT
Message-ID: <1331218917.3006.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Date: Thu, 08 Mar 2012 07:01:57 -0800
In-Reply-To: <CAEsOVNfV1iy1Npks-3fuT0g+sLXenNMc8+n_mAV-t9RX6AtcSQ@mail.gmail.com>
References: <1330834637.3949.8.camel@ted>
	<CAEsOVNfV1iy1Npks-3fuT0g+sLXenNMc8+n_mAV-t9RX6AtcSQ@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] parse/ast: Expand inherit statements before splitting them
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
X-List-Received-Date: Thu, 08 Mar 2012 15:11:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-07 at 22:13 +0000, McClintock Matthew-B29882 wrote:
> On Sat, Mar 3, 2012 at 10:17 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > This means that statements that expand to more then one entry
> > such as:
> >
> > CLASSES = "a b"
> > inherit ${CLASSES}
> >
> > work correctly instead of trying to inherit a class called "a b".
> 
> Does this effect:
> 
> CLASSES = ""
> 
> inherit a ${CLASSES}

Possibly in that if it didn't work before, it perhaps does now. I
certainly can't see the change making this any less functional.

Cheers,

Richard



