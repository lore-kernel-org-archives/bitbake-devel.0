Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D4BF77744C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 21:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u53LE5Xt003962; Fri, 3 Jun 2016 22:14:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Xe9A-nWCkDFr; Fri,  3 Jun 2016 22:14:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u53LE2GX003959
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 3 Jun 2016 22:14:03 +0100
Message-ID: <1464988442.13979.28.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Fri, 03 Jun 2016 22:14:02 +0100
In-Reply-To: <CABcZANn2ctcqA0hUzw47F_n6n1EQoAS16axALFhUCeaR1p0JSg@mail.gmail.com>
References: <1464957513.13979.16.camel@linuxfoundation.org>
	<CABcZANn2ctcqA0hUzw47F_n6n1EQoAS16axALFhUCeaR1p0JSg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Fri, 03 Jun 2016 21:14:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-06-03 at 11:34 -0700, Christopher Larson wrote:
> 
> On Fri, Jun 3, 2016 at 5:38 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> > "hash() is randomised by default each time you start a new instance
> > of
> > recent
> > versions (Python3.3+) to prevent dictionary insertion DOS attacks"
> > 
> > which means we need to use hashlib.md5 to get consistent values for
> > the codeparser cache under python 3. Prior to this, the codeparser
> > cache was effectively useless under python3 as shown by performance
> > regressions.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> Looks good to me, I was actually wondering about the hashing
> mechanisms just yesterday. Are the sstate checksums stable between
> python 2 and python 3?

I've not actually checked, we didn't intentionally break anything. It
doesn't actually matter that much since the python code between the two
is different and hence the checksums will change...

Cheers,

Richard


