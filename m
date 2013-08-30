Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0E81C6BD9E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Aug 2013 16:43:44 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7UGuJeB009682; Fri, 30 Aug 2013 17:56:20 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 494zR4txOjpl; Fri, 30 Aug 2013 17:56:19 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7UGuG5e009673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 30 Aug 2013 17:56:17 +0100
Message-ID: <1377881012.1059.101.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Peter A. Bigot" <pab@pabigot.com>
Date: Fri, 30 Aug 2013 17:43:32 +0100
In-Reply-To: <1377783495.1059.4.camel@ted>
References: <1377695062-16111-1-git-send-email-pab@pabigot.com>
	<521DFDAE.5040507@windriver.com> <521E025B.7070308@pabigot.com>
	<1377783495.1059.4.camel@ted>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: server/xmlrpc/prserv: Increase timeout to default xmlrpc server
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
X-List-Received-Date: Fri, 30 Aug 2013 16:43:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-08-29 at 14:38 +0100, Richard Purdie wrote:
> On Wed, 2013-08-28 at 08:59 -0500, Peter A. Bigot wrote:
> > On 08/28/2013 08:39 AM, Jason Wessel wrote:
> > > On 08/28/2013 08:04 AM, Peter A. Bigot wrote:
> > >> On a heavily-loaded host with local PR server the default 5 second timeout
> > >> produces too-frequent errors:
> > >>
> > >>    ERROR: Can NOT get PRAUTO, exception timed out
> > >>    ERROR: Function failed: package_get_auto_pr
> > >>
> > >> Since this error aborts the build a generous timeout seems appropriate.
> > >>
> > >> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
> > >> ---
> > >>   lib/bb/server/xmlrpc.py | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
> > >> index 4dee5d9..bb87fd7 100644
> > >> --- a/lib/bb/server/xmlrpc.py
> > >> +++ b/lib/bb/server/xmlrpc.py
> > >> @@ -78,7 +78,7 @@ class BBTransport(xmlrpclib.Transport):
> > >>               h.putheader("Bitbake-token", self.connection_token)
> > >>           xmlrpclib.Transport.send_content(self, h, body)
> > >>   
> > >> -def _create_server(host, port, timeout = 5):
> > >> +def _create_server(host, port, timeout = 20):
> > >>       t = BBTransport(timeout)
> > >>       s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
> > >>       return s, t
> > >
> > > I would go so far as to make this 60 seconds and or have it a configurable parameter.
> > >
> > > Previously the timeout was infinite.   I have observed process creation lagging by 30-45 seconds on a server with a load average of +300.   The new bitbake python code with the reduced timeout is not yet running on our edge case testing environment, but I do expect to hit the same issue.
> > 
> > Not sure when the timeout was added, but I believe it was before the 
> > modifications in the last few days that moved it to this function; I've 
> > been having this problem since switching to poky master.
> > 
> > 60 seconds would be fine with me; I could update the patch for that.  A 
> > configurable parameter would be better but it wasn't obvious how to do 
> > it, so if people prefer that approach I'd rather a bitbake maintainer 
> > take over from here.
> 
> The downside is that if something goes wrong this ends up leaving
> bitbake hanging for 60 seconds at exit whilst it tries to connect to a
> server which is never going to exist. I'm rather frustrated that the PR
> service is so slow since this will block the packaging process for that
> length or time.
> 
> With that in mind I've radically improved the performance of the server
> with threading. Can people retest with master and see how things behave
> now?

Looking at the number of people hitting this, I've set it to 60s. 

Cheers,

Richard


