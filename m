Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 05FCE71A15
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 06:13:34 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v0J6DYvd011506
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jan 2017 22:13:34 -0800
Received: from [128.224.162.160] (128.224.162.160) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 18 Jan 2017 22:13:33 -0800
To: Mark Hatle <mark.hatle@windriver.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <f8610648-ea83-06ab-01fa-f8260597973c@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <a8d463a0-f40a-afaf-c326-1f3bdffd49b7@windriver.com>
Date: Thu, 19 Jan 2017 14:13:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <f8610648-ea83-06ab-01fa-f8260597973c@windriver.com>
Subject: Re: Filename too long
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
X-List-Received-Date: Thu, 19 Jan 2017 06:13:35 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

We have a local patch to fix the problem, I had sent it to bitbake-devel
before, but not merged:

https://patchwork.openembedded.org/patch/61321/

Here is the updated patch in our bitbake:

commit ebb1190c01a15fc6e91c9810c46313c3b3fb305c
Author: Robert Yang <liezhi.yang@windriver.com>
Date:   Fri Nov 8 23:32:11 2013 +0800

     fetch2/git.py: fix the filename too long error

     When we use the PREMIRROR/MIRROR from the local disk, and if it is in a
     deep directory, for example, when len(path) > 255 (The NAME_MAX), we
     will get the "filename too long error".

     This is becuase we use ud.path.replace('/', '.') to change the path to
     the filename. We seldom see such a long url, but it is easy to produce
     it on the local machine.

     Another problem is that:

     file:///local/path

     will be converted into .local.path which is a hidden file by default.

     Don't convert the name when ud.proto == "file" will fix the problem.

     Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f7a0c01..cc17e5a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -195,7 +195,10 @@ class Git(FetchMethod):
                      ud.unresolvedrev[name] = ud.revisions[name]
                  ud.revisions[name] = self.latest_revision(ud, d, name)

-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', 
'.').replace('*', '.'))
+        if ud.proto == "file":
+            gitsrcname = '%s%s' % ("file...", os.path.basename(ud.path))
+        else:
+            gitsrcname = '%s%s' % (ud.host.replace(':', '.'), 
ud.path.replace('/', '.').replace('*', '.'))
          if gitsrcname.startswith('.'):
              gitsrcname = gitsrcname[1:]


// Robert

On 01/19/2017 03:02 AM, Mark Hatle wrote:
> I found a problem today working through a problem report.
>
> We have a situation where we automatically add certain project directories as
> premirrors within the environment.
>
> During the fetch2 work, the system takes this long pathname, and then embeds it
> into ud.lockfile parameter, we end up with something like:
>
> The path to the build/download dir is about 250 characters... (abbreviated below)
>
> ud.lockfile =
> /my/really/log/path/to/my/project/build/download/git2/file....my.really.log.path.to.my.project.layers.wr-kernel.recipes-kernel.linux.......git.kernel-4.8.x.git.lock
>
> This triggers an exception, IOError with the errno '36', and error string of
> 'File name too long'.  (Note, this is the filename, NOT the path being too long!)
>
> In the bitbake/lib/bb/utils.py: def lockfile(name, shared=False, retry=True,
> block=False)
>
> The system tries to:
>
> while True:
>     try:
>         lf = open(name, 'a+')
>         ... more work here ...
>     except Exception:
>         ... close the file, if opened ...
>         pass
>     if not retry:
>         return None
>
> This triggers an endless loop if this happens.
>
> So at a minimum we probably need to extend the exception handling to look for
> file (or path) too long errors and return/stop.
>
> I'm wondering if, something like the following should be added:
>
>  exception IOError as e:
>      errno, strerror = e.args
>      logger.fatal("IOError on lock: [%s] %s" % (errno, strerror))
>      try:
>          lf.close()
>      except Exception:
>          pass
>      retry = False
>      pass
>
> (Is stopping on all IOErrors too broad of a check?)
>
>
> Second, I'm not sure where the lockfile name is determined, but should there be
> a way in there to shorten the lockfile to say the 'basename' instead of a full
> path (if specified)?
>
> Any suggestions would be appreciated.
>
> --Mark
>

