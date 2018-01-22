Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2486378257
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Jan 2018 22:08:38 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0MM8Wbq014770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 22 Jan 2018 22:08:33 GMT
Message-ID: <1516658912.24502.119.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>, Amanda Brindle
	<amanda.r.brindle@intel.com>
Date: Mon, 22 Jan 2018 22:08:32 +0000
In-Reply-To: <6192920.y9QKLpEl5j@peggleto-mobl.ger.corp.intel.com>
References: <cover.1516394932.git.amanda.r.brindle@intel.com>
	<57f40b8b016e6f9e4539d919d323dd6b6d75c31a.1516394932.git.amanda.r.brindle@intel.com>
	<6192920.y9QKLpEl5j@peggleto-mobl.ger.corp.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] tinfoil.py: Check if BUILDDIR exists
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
X-List-Received-Date: Mon, 22 Jan 2018 22:08:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2018-01-23 at 09:02 +1300, Paul Eggleton wrote:
> Hi Amanda,
> 
> On Saturday, 20 January 2018 9:53:13 AM NZDT Amanda Brindle wrote:
> > 
> > +        basepath = os.environ.get('BUILDDIR')
> > +        if not basepath:
> > +            print("Tinfoil can only be run after initialising the
> > build
> > environment (e.g. by using oe-init-build-env)")
> > +            sys.exit(1)
> > +
> We should be raising an exception here - tinfoil is utility code, it
> shouldn't 
> be calling sys.exit(). Additionally, bitbake shouldn't be referring
> to 
> oe-init-build-env, that's something from OpenEmbedded; even
> mentioning Tinfoil 
> isn't going to be much use to the user. I would simply raise a
> custom 
> exception class with the message "Build environment not initialised"
> or 
> similar, and if tinfoil-using want to catch that exception and
> produce a more 
> friendly message they can fairly easily do so.

This was also triggering on the autobuilder tests so something isn't
quite right here:

https://autobuilder.yocto.io/builders/nightly-x86-64/builds/744/steps/Running%20ESDK%20Sanity%20Tests/logs/stdio

Cheers,

Richard

