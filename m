Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJgLL-0002WU-Vo
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 09:27:24 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 16 Apr 2012 00:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131331557"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 16 Apr 2012 00:17:57 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1334098817.10826.89.camel@ted>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
	<ccb22c39f4aeb8e310f9a6f8e0f9c55c18ac6891.1333960654.git.dongxiao.xu@intel.com>
	<1334098817.10826.89.camel@ted>
Date: Mon, 16 Apr 2012 15:15:04 +0800
Message-ID: <1334560504.4305.6.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
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
X-List-Received-Date: Mon, 16 Apr 2012 07:27:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-04-11 at 00:00 +0100, Richard Purdie wrote:
> On Mon, 2012-04-09 at 16:41 +0800, Dongxiao Xu wrote:
> > The order of keys are not sensitive for config hash, so we need to
> > identify its order while calculating the md5 value.
> > 
> > While for certain values, order is also not sensitive (for example,
> > BBINCLUDED), we also need to identify its order while calculating md5
> > value.
> > 
> > This could fix the problem that Martin Jansa reported in the mailing
> > list:
> > 
> > http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-March/002122.html
> > 
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > ---
> >  lib/bb/data_smart.py |   10 +++++++---
> >  1 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > index 2c200db..cc61a03 100644
> > --- a/lib/bb/data_smart.py
> > +++ b/lib/bb/data_smart.py
> > @@ -462,13 +462,17 @@ class DataSmart(MutableMapping):
> >          self.delVar(var)
> >  
> >      def get_hash(self):
> > -        data = ""
> > +        data = {}
> >          config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
> > +        config_sort = set((self.getVar("BB_HASHCONFIG_SORT", True) or "").split())
> >          keys = set(key for key in iter(self) if not key.startswith("__"))
> >          for key in keys:
> >              if key in config_whitelist:
> >                  continue
> >              value = self.getVar(key, False) or ""
> > -            data = data + key + ': ' + str(value) + '\n'
> > +            if key in config_sort:
> > +                value = " ".join(sorted(value.split()))
> > +            data.update({key:value})
> >  
> > -        return hashlib.md5(data).hexdigest()
> > +        data_str = str([(k, data[k]) for k in sorted(data.keys())])
> > +        return hashlib.md5(data_str).hexdigest()
> 
> 
> This and the corresponding change in bitbake.conf look rather worrying
> to me. The order in BBINCLUDED is significant and if it changes we
> should be reparsing.

Hi Richard,

Why do you say the order in BBINCLUDED is significant?

I saw the original code ignores the order when handling __depends and
__base_depends.

For example:

def mark_dependency(d, f):
    if f.startswith('./'):
        f = "%s/%s" % (os.getcwd(), f[2:]) 
    deps = d.getVar('__depends') or set() 
    deps.update([(f, cached_mtime(f))])
    d.setVar('__depends', deps)    

I think the get_file_depends(d) just follows the original logic.

Or do you mean the mark_dependency(d, f) is also buggy?

Thanks,
Dongxiao

> 
> Looking at the code, get_file_depends(d) is probably buggy due to the
> use of set() which could reorder the data. We need to keep the data in
> order there and this issue should then be resolved.
> 
> Lets fix the real bug.
> 
> Cheers,
> 
> Richard
> 
> 
> 




