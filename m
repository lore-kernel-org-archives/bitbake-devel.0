Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TvnVl-0004Zb-IP for bitbake-devel@lists.openembedded.org;
	Thu, 17 Jan 2013 12:20:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0HB4Ytf031007;
	Thu, 17 Jan 2013 11:04:34 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23524-07; Thu, 17 Jan 2013 11:04:29 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0HB4Rqk031001
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2013 11:04:28 GMT
Message-ID: <1358420667.24249.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Thu, 17 Jan 2013 11:04:27 +0000
In-Reply-To: <20130116120104.1d40cced@e6410-2>
References: <cover.1357954043.git.peter.seebach@windriver.com>
	<1358358898.24249.8.camel@ted> <20130116120104.1d40cced@e6410-2>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Variable tracking: Cleaned up and rebased.
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
X-List-Received-Date: Thu, 17 Jan 2013 11:20:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-01-16 at 12:01 -0600, Peter Seebach wrote:
> On Wed, 16 Jan 2013 17:54:58 +0000
> Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
> 
> > I *really* want to take these, however I did want to check
> > performance:
> 
> Oh, good thought.
> 
> > $ time bitbake core-image-sato -e
> > real	0m8.034s
> > $ time bitbake -p
> > real	0m12.220s
> > user	3m3.887s
>  
> > After:
>  
> > $ time bitbake core-image-sato -e
> > real	0m50.267s
> > $ time bitbake -p
> > real	0m14.607s
> > user	3m55.179s
> 
> Hmm. That doesn't totally surprise me.
>  
> > The 50s seems a touch excessive and it looks like a 20% parsing hit
> > even when unused :(. Note the overall parsing times on this machine
> > are fast as its running 24 in parallel. I'm going to try and figure
> > out what is going on tomorrow as I've fixed a lot of this kind of
> > thing in the past but wanted to mention it...
> 
> The 50s seems... not entirely surprsing. I don't know that much about
> how Python does stuff, but in practice we end up with a LOT of deep
> copies of structures floating around because there are a ton of data
> copies; without these, finalize information gets duplicated and things
> go pretty wrong.
> 
> My intuition is that the stack backtrace thing is probably expensive,
> and might be noticably reduced by manually passing in the
> likely-missing values in cases where we know what they are, so it's
> less likely that any backtracing has to happen.

Its not the stack backtrace stuff that is the limiting factor here, its
the deepcopy, its really clear on the profiles. Anything with 48 million
calls is a problem, we should be seeing 10s of thousands of calls tops
for an operation like the above.

I tried a little experiment:

--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -174,7 +174,14 @@ class IncludeHistory(object):
         self.filename = filename or '[TOP LEVEL]'
         self.children = []
         self.current = self
-        self.variables = {}
+        self.variables = COWDictBase.copy()
+
+    def copy(self):
+        new = IncludeHistory(self.parent, self.filename, self.datasmart)
+        new.children = copy.deepcopy(self.children)
+        new.current = self.current
+        new.variables = self.variables.copy()
+        return new
 
     def include(self, filename):
         newfile = IncludeHistory(self.current, filename)
@@ -615,7 +622,7 @@ class DataSmart(MutableMapping):
         # we really want this to be a DataSmart...
         data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
         data.dict["_data"] = self.dict
-        data.history = copy.deepcopy(self.history)
+        data.history = self.history.copy()
         data.history.datasmart = data
         data._tracking = self._tracking
 
which replaces the brute force deepcopy with a more intelligent attempt
to copy the IncludeHistory object. I've replaced the variables dict with
our magic COW dict object since this is the kind of usage it was
designed for.

What is interesting is that even with profiling enabled (-P), this drops
the execution time to 10s from 50s so it proves my theory about
deepcopy. Diffing the output before and after shows that it even
faithfully handles the variable dependencies, it does however totally
break the include list, as I break "current".

It does seem we're trying to merge two orthogonal sets of data into one
object here (include history and variable history) and this results in a
huge number of IncludeHistory instances in memory though the include
chain. I'm therefore left wondering if we could separate the two?

Cheers,

Richard



