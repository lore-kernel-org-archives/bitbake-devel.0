Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2B9A3786D2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 16:53:17 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1QGrGXf023783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 26 Feb 2018 16:53:18 GMT
Message-ID: <1519663996.24236.387.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@toganlabs.com>
Date: Mon, 26 Feb 2018 16:53:16 +0000
In-Reply-To: <CAPyrkgzzasujqZ1D5pABM+vudjjaM=4wdVuseFNB8u0OHVdMCA@mail.gmail.com>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
	<CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
	<1519596717.24236.384.camel@linuxfoundation.org>
	<CAPyrkgxDenV61oP1CZLFSFueqM3NXo2BOptNgSFTDnRHpm62iQ@mail.gmail.com>
	<CAPyrkgzzasujqZ1D5pABM+vudjjaM=4wdVuseFNB8u0OHVdMCA@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
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
X-List-Received-Date: Mon, 26 Feb 2018 16:53:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2018-02-25 at 22:20 +0000, Paul Barker wrote:
> On Sun, Feb 25, 2018 at 10:17 PM, Paul Barker <pbarker@toganlabs.com>
> wrote:
> > 
> > On Sun, Feb 25, 2018 at 10:11 PM, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > 
> > > On Sun, 2018-02-25 at 19:25 +0000, Paul Barker wrote:
> > > > 
> > > > I've been having build failures recently which I've tracked
> > > > down to
> > > > this commit in bitbake via git bisect.
> > > > 
> > > > I have an image recipe, oryx-image, and a publish recipe,
> > > > oryx-publish. In oryx-publish I have a do_publish task that
> > > > copies
> > > > files out of "tmp/deploy/images/*" to their final places and so
> > > > it
> > > > needs to run after the tasks in oryx-image that create the
> > > > relevant
> > > > files. So I've explicitly added oryx-image:do_build to
> > > > do_publish[depends].
> > > Is do_publish added before do_build?
> > > Does oryx-publish inherit any of the image/meta classes?
> > > 
> > > I suspect I need to better understand the problem as you've
> > > described
> > > what you think the problem is but not what problem you're
> > > seeing...
> > > 
> > The recipe is here:
> > https://gitlab.com/oryx/meta-oryx/blob/master/recipes-core/publish/
> > oryx-publish.bb.
> > ORYX_SYSTEM_PROFILE_PUBLISH_DEPENDS expands to "oryx-
> > image:do_build".
> > 
> > The problem I'm seeing is that the files don't exist in
> > "tmp/deploy/images/*" when do_publish runs. Investigation via
> > "bitbake
> > -g" shows that the dependency on "oryx-image:do_build" has been
> > dropped from do_publish:
> > 
> Somehow trying to paste resulted in the email being sent.... stupid
> gmail!
> 
> The problem I'm seeing is that the files don't exist in
> "tmp/deploy/images/*" when do_publish runs. Investigation via
> "bitbake
> -g" shows that the dependency on "oryx-image:do_build" has been
> dropped from do_publish:
> 
> "oryx-publish.do_publish" [label="oryx-publish
> do_publish\n:1.0-r0\n/home/pbarker/oryx/meta-oryx/recipes-
> core/publish/oryx-publish.bb"]
> "oryx-publish.do_publish" -> "image-json-file.do_build"
> 
> Commenting out the following lines in lib/bb/runqueue.py seems to
> improve things for me but I know this is just a hack:
> 
>         for tid in self.runtaskentries:
>             self.runtaskentries[tid].depends.difference_update(recurs
> ivetasksselfref)
> 
> With those commented out, the dependencies are correct for
> do_publish:
> 
> "oryx-publish.do_publish" [label="oryx-publish
> do_publish\n:1.0-r0\n/home/pbarker/oryx/meta-oryx/recipes-
> core/publish/oryx-publish.bb"]
> "oryx-publish.do_publish" -> "image-json-file.do_build"
> "oryx-publish.do_publish" -> "oryx-image.do_build"

Thanks, more information helped. I think you have found a bug. I'm
wondering about:

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 48df0131556..f2e52cf758c 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -765,7 +765,7 @@ class RunQueueData:
             bb.debug(1, "Added %s recursive dependencies in this loop" % extradeps)
 
         # Remove recrdeptask circular references so that do_a[recrdeptask] = "do_a do_b" can work
-        for tid in self.runtaskentries:
+        for tid in recursivetasksselfref:
             self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
 
         self.init_progress_reporter.next_stage()

as a fix for it...

Cheers,

Richard

