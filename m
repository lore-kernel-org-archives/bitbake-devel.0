Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 748967743E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHBRGw006138; Fri, 26 Feb 2016 17:11:27 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BcM67v-mHhGp; Fri, 26 Feb 2016 17:11:27 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHBOuE006134
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 26 Feb 2016 17:11:25 GMT
Message-ID: <1456506683.11498.86.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Sasha Shashkevich <alex@stunpix.com>
Date: Fri, 26 Feb 2016 17:11:23 +0000
In-Reply-To: <1456505497.11498.81.camel@linuxfoundation.org>
References: <1456417951-11336-1-git-send-email-alex@stunpix.com>
	<1456483880.11498.68.camel@linuxfoundation.org>
	<8F8D0DA4-2383-4900-A0C6-9AAEA334C568@stunpix.com>
	<1456487187.11498.70.camel@linuxfoundation.org>
	<1456505497.11498.81.camel@linuxfoundation.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
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
X-List-Received-Date: Fri, 26 Feb 2016 17:11:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2016-02-26 at 16:51 +0000, Richard Purdie wrote:
> On Fri, 2016-02-26 at 11:46 +0000, Richard Purdie wrote:
> > On Fri, 2016-02-26 at 13:30 +0200, Sasha Shashkevich wrote:
> > > > On Feb 26, 2016, at 12:51, Richard Purdie <
> > > > richard.purdie@linuxfoundation.org> wrote:
> > > > 
> > > > On Thu, 2016-02-25 at 18:32 +0200, Alexander Shashkevich wrote:
> > > > > When in SRC_URI appears file://dir;subdir=foo unpacker copies
> > > > > 'dir'
> > > > > to ${WORKDIR}, not
> > > > > ${WORKDIR}/foo as it should be.
> > > > > 
> > > > > These changes are fixing following bugs as well:
> > > > > Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
> > > > > Bug 6129 - Local directories unpack to a different location
> > > > > than
> > > > > local files
> > > > 
> > > > Sadly, this change isn't without side effects. For example:
> > > > 
> > > > https://autobuilder.yoctoproject.org/main/builders/nightly-x86-
> > > > 64
> > > > /b
> > > > uilds/680/steps/Building%20Toolchain%20Images/logs/stdio
> > > > 
> > > > > NOTE: Unpacking /home/pokybuild/yocto-autobuilder/yocto
> > > > > -worker/nightly-x86-64/build/scripts/runqemu to
> > > > > /home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86
> > > > > -64/build/build/tmp/work/i686-nativesdk-pokysdk
> > > > > -linux/nativesdk
> > > > > -qemu-helper/1.0-r9/
> > > > > cp: `/home/pokybuild/yocto-autobuilder/yocto-worker/nightly
> > > > > -x86
> > > > > -64/build/scripts/runqemu' and `/home/pokybuild/yocto
> > > > > -autobuilder/yocto-worker/nightly-x86
> > > > > -64/build/scripts/runqemu'
> > > > > are the same file
> > > > > DEBUG: Python function base_do_unpack finished
> > > > > DEBUG: Python function do_unpack finished
> > > 
> > > 
> > > Despite all tests were successfully passed, something remains
> > > incorrect. Very sensitive feature. I'll check what is wrong and
> > > supply additional test cases with updated patch. Seems I need to
> > > build several configurations locally before submitting such
> > > patches
> > > –
> > > just tests are not enough.
> > 
> > Yes, sadly our tests aren't entirely complete. I'd much appreciate
> > added test cases if we can figure out what the issue is.
> > 
> > This change does introduce a change in behaviour, admittedly one
> > where
> > we think the current behaviour is incorrect. It is possible recipes
> > are
> > relying on that incorrect behaviour though and they may need
> > adjusting.
> 
> FWIW, a:
> 
> -                if urldata.type == "file":
> +                if urldata.type == "file" and not
> urldata.path.startswith("/"):
> 
> did seem to fix the failing recipe which was doing something valid.
> What 
> effect elsewhere this has I haven't checked.

I'm wrong, the correct fix appears to be:

-                    urlpath = urldata.path.rstrip('/') # Trailing '/' does a copying to wrong place
+                    # Trailing '/' does a copying to wrong place
+                    urlpath = urldata.path.rstrip('/')
+                    # Want files places relative to cwd so no leading '/'
+                    urldata.path.lstrip('/')

and we're missing a test case with absolute file:// urls.

Cheers,

Richard


