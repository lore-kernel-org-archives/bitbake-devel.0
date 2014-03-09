Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2293A6F609
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 18:13:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29IBVCG021500; Sun, 9 Mar 2014 18:13:47 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 33uTqYa_fjpJ; Sun,  9 Mar 2014 18:13:46 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29IDahv021532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 9 Mar 2014 18:13:41 GMT
Message-ID: <1394388811.7883.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kristof Robot <krirobo@gmail.com>
Date: Sun, 09 Mar 2014 11:13:31 -0700
In-Reply-To: <CAFgGSN6AaG6ZPPUmJzqiJeYXDK1mKyG=i8vH6q=u8E63fPT6OQ@mail.gmail.com>
References: <CAFgGSN6AaG6ZPPUmJzqiJeYXDK1mKyG=i8vH6q=u8E63fPT6OQ@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch/wget: Start to clean up command construction
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
X-List-Received-Date: Sun, 09 Mar 2014 18:13:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-03-06 at 21:41 +0100, Kristof Robot wrote:
> >Start to clean up wget fetcher command construction to allow clearer
> >and more extensible code structure. Drops support for ${URI} and
> >${FILE} directly in the commands.
> >
> >Signed-off-by: Richard Purdie <richard.purdie at linuxfoundation.org>
> >[...]
> >         if not checkonly and 'downloadfilename' in ud.parm:
> >             dldir = d.getVar("DL_DIR", True)
> >             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
> >-            basecmd += " -O " + dldir + os.sep + ud.localfile
> >+            fetchcmd += " -O " + dldir + os.sep + ud.localfile
> >
> >+        uri = ud.url.split(";")[0]
> >         if checkonly:
> >-            fetchcmd = d.expand(basecmd + " --spider '${URI}'")
> >+            fetchcmd = self.basecmd + " --spider '%s'" % uri
> >         elif os.path.exists(ud.localpath):
> >             # file exists, but we didnt complete it.. trying again..
> >-            fetchcmd = d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
> >+            fetchcmd = self.basecmd + d.expand(" -c -P ${DL_DIR} '%s'" % uri)
> >         else:
> >-            fetchcmd = d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
> >-
> 
> This patch breaks the "downloadfilename" functionality, as the
> fetchcmd append in the first if structure will be overwritten by the
> fetchcmd assignments in the second if structure, effectively losing
> the appended information.
> 
> As a quick fix, I replaced
> 
>  fetchcmd += " -O " + dldir + os.sep + ud.localfile
> 
> by
> 
>  self.basecmd += " -O " + dldir + os.sep + ud.localfile
> 
> but there might be a better way of resolving this?

Thanks, looking at the code I think I was intending it to work
differently but confused things somewhere through the various patches.
I've pushed a fix that should resolve this, thanks for the report!

Cheers,

Richard


