Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SfBAm-0007g6-56 for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 16:37:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5EEQhjT001950;
	Thu, 14 Jun 2012 15:26:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01153-07; Thu, 14 Jun 2012 15:26:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5EEQXYG001943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 15:26:35 +0100
Message-ID: <1339683993.24333.81.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Thu, 14 Jun 2012 15:26:33 +0100
In-Reply-To: <4FD9E81D.6030808@windriver.com>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
	<1339643381-23026-5-git-send-email-jason.wessel@windriver.com>
	<1339679039.24333.76.camel@ted> <4FD9E81D.6030808@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] fetch2/git.py: Optimize clone fall back when it is local
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
X-List-Received-Date: Thu, 14 Jun 2012 14:37:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-14 at 08:33 -0500, Jason Wessel wrote:
> On 06/14/2012 08:03 AM, Richard Purdie wrote:
> > On Wed, 2012-06-13 at 22:09 -0500, Jason Wessel wrote:
> >> A file:// url should use "clone -s" to greatly speed
> >> up the clone in the case of a kernel when it is local.
> >>
> >> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> >> ---
> >>  lib/bb/fetch2/git.py |    8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> >> index 1ad9213..f5a3983 100644
> >> --- a/lib/bb/fetch2/git.py
> >> +++ b/lib/bb/fetch2/git.py
> >> @@ -192,7 +192,13 @@ class Git(FetchMethod):
> >>  
> >>          # If the repo still doesn't exist, fallback to cloning it
> >>          if not os.path.exists(ud.clonedir):
> >> -            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
> >> +            if repourl.startswith("file://"):
> >> +                use_s = "-s"
> >> +                repo = repourl[7:]
> >> +            else:
> >> +                use_s = ""
> >> +                repo = repourl
> >> +            clone_cmd = "%s clone %s --bare --mirror %s %s" % (ud.basecmd, use_s, repo, ud.clonedir)
> >>              if ud.proto.lower() != 'file':
> >>                  bb.fetch2.check_network_access(d, clone_cmd)
> >>              runfetchcmd(clone_cmd, d)
> > 

I think you can then simplify this to:

@@ -192,7 +192,9 @@ class Git(FetchMethod):
  
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
+            if repourl.startswith("file://"):
+                repo = repourl[7:]
+            clone_cmd = "%s clone -l --bare --mirror %s %s" % (ud.basecmd, repo, ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd)
             runfetchcmd(clone_cmd, d)
 
Cheers,

Richard



