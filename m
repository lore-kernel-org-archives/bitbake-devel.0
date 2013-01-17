Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tvnu8-0005Q7-Co for bitbake-devel@lists.openembedded.org;
	Thu, 17 Jan 2013 12:45:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0HBTj0t031144;
	Thu, 17 Jan 2013 11:29:45 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20832-08; Thu, 17 Jan 2013 11:29:41 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0HBTdR8031138
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2013 11:29:40 GMT
Message-ID: <1358422179.24249.24.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Thu, 17 Jan 2013 11:29:39 +0000
In-Reply-To: <1358420667.24249.18.camel@ted>
References: <cover.1357954043.git.peter.seebach@windriver.com>
	<1358358898.24249.8.camel@ted> <20130116120104.1d40cced@e6410-2>
	<1358420667.24249.18.camel@ted>
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
X-List-Received-Date: Thu, 17 Jan 2013 11:45:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I figured out the issue, I shouldn't have been touching current at all.
Rather than deepcopy, its also better to use our own copy operation on
the children:

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
+        for c in self.children:
+            new.children.append(c.copy())
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
 
So with this applied, we get -e taking around 10s and parsing 3m26 so
about a 10% increase and the output of -e is the same before and after
that patch. I'm still not happy but that is obviously a better
proposition.

The real issue is these highly recursive and duplicate data structures
are inefficient so I think there is still much room for improvement.
Separating the variable and include history will likely help a lot.

The main point of the above is to prove how much the deepcopy hurts us
and also that there are ways we can fix it.

Cheers,

Richard




