Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SJhwd-0000Ku-Ly for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 11:10:00 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3G90UFd030054;
	Mon, 16 Apr 2012 10:00:30 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28589-05; Mon, 16 Apr 2012 10:00:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3G90Mw3030047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Apr 2012 10:00:23 +0100
Message-ID: <1334566826.16992.66.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Date: Mon, 16 Apr 2012 10:00:26 +0100
In-Reply-To: <1334565710.26744.1.camel@dongxiao-osel>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
	<ccb22c39f4aeb8e310f9a6f8e0f9c55c18ac6891.1333960654.git.dongxiao.xu@intel.com>
	<1334098817.10826.89.camel@ted> <1334560504.4305.6.camel@dongxiao-osel>
	<1334564893.16992.64.camel@ted>
	<1334565710.26744.1.camel@dongxiao-osel>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/6] data_smart: Improve the calculation of config hash
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
X-List-Received-Date: Mon, 16 Apr 2012 09:10:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-04-16 at 16:41 +0800, Xu, Dongxiao wrote:
> On Mon, 2012-04-16 at 09:28 +0100, Richard Purdie wrote:
> > On Mon, 2012-04-16 at 15:15 +0800, Xu, Dongxiao wrote:
> > > On Wed, 2012-04-11 at 00:00 +0100, Richard Purdie wrote:
> > > > On Mon, 2012-04-09 at 16:41 +0800, Dongxiao Xu wrote:
> > > > > The order of keys are not sensitive for config hash, so we need to
> > > > > identify its order while calculating the md5 value.
> > > > > 
> > > > > While for certain values, order is also not sensitive (for example,
> > > > > BBINCLUDED), we also need to identify its order while calculating md5
> > > > > value.
> > > > > 
> > > > > This could fix the problem that Martin Jansa reported in the mailing
> > > > > list:
> > > > > 
> > > > > http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-March/002122.html
> > > > > 
> > > > > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > > > > ---
> > > > >  lib/bb/data_smart.py |   10 +++++++---
> > > > >  1 files changed, 7 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > > > > index 2c200db..cc61a03 100644
> > > > > --- a/lib/bb/data_smart.py
> > > > > +++ b/lib/bb/data_smart.py
> > > > > @@ -462,13 +462,17 @@ class DataSmart(MutableMapping):
> > > > >          self.delVar(var)
> > > > >  
> > > > >      def get_hash(self):
> > > > > -        data = ""
> > > > > +        data = {}
> > > > >          config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
> > > > > +        config_sort = set((self.getVar("BB_HASHCONFIG_SORT", True) or "").split())
> > > > >          keys = set(key for key in iter(self) if not key.startswith("__"))
> > > > >          for key in keys:
> > > > >              if key in config_whitelist:
> > > > >                  continue
> > > > >              value = self.getVar(key, False) or ""
> > > > > -            data = data + key + ': ' + str(value) + '\n'
> > > > > +            if key in config_sort:
> > > > > +                value = " ".join(sorted(value.split()))
> > > > > +            data.update({key:value})
> > > > >  
> > > > > -        return hashlib.md5(data).hexdigest()
> > > > > +        data_str = str([(k, data[k]) for k in sorted(data.keys())])
> > > > > +        return hashlib.md5(data_str).hexdigest()
> > > > 
> > > > 
> > > > This and the corresponding change in bitbake.conf look rather worrying
> > > > to me. The order in BBINCLUDED is significant and if it changes we
> > > > should be reparsing.
> > > 
> > > Hi Richard,
> > > 
> > > Why do you say the order in BBINCLUDED is significant?
> > > 
> > > I saw the original code ignores the order when handling __depends and
> > > __base_depends.
> > > 
> > > For example:
> > > 
> > > def mark_dependency(d, f):
> > >     if f.startswith('./'):
> > >         f = "%s/%s" % (os.getcwd(), f[2:]) 
> > >     deps = d.getVar('__depends') or set() 
> > >     deps.update([(f, cached_mtime(f))])
> > >     d.setVar('__depends', deps)    
> > > 
> > > I think the get_file_depends(d) just follows the original logic.
> > > 
> > > Or do you mean the mark_dependency(d, f) is also buggy?
> > 
> > In that case I think the original code is also buggy.
> 
> Could you explain more why __depends should be ordered? I saw the
> variable's definition is set() type and there is no code depends on the
> order of "__depends".

Well, your new code does!

Bitbake does care deeply about the order things are included in so I
believe this variable should reflect that.

Cheers,

Richard




