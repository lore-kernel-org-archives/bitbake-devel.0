Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <darren.hart@intel.com>) id 1Ue7Fx-0000FH-2t
	for bitbake-devel@lists.openembedded.org;
	Sun, 19 May 2013 19:18:50 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 19 May 2013 09:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,704,1363158000"; d="scan'208";a="316221435"
Received: from unknown (HELO envy2.home) ([10.255.12.55])
	by orsmga001.jf.intel.com with ESMTP; 19 May 2013 09:59:23 -0700
Message-ID: <519904EC.4070509@intel.com>
Date: Sun, 19 May 2013 09:59:24 -0700
From: Darren Hart <darren.hart@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1368958678.32727.92.camel@ted>
In-Reply-To: <1368958678.32727.92.camel@ted>
X-Mailman-Approved-At: Mon, 20 May 2013 10:46:31 +0200
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Clean up sortable_revision
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
X-List-Received-Date: Sun, 19 May 2013 17:18:55 -0000
X-List-Received-Date: Sun, 19 May 2013 17:18:55 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/19/2013 03:17 AM, Richard Purdie wrote:
> Now we no longer try and provide increasing values from the fetcher,
> we can simplify the function structure for the sortable_revision
> pieces and move the AUTOINC handling directly into the function
> which needs it, simplifying the code.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index dd1cc93..f8f8244 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -616,7 +616,10 @@ def get_srcrev(d):
>          raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
>  
>      if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
> -        return urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
> +        autoinc, rev = urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
> +        if autoinc:
> +            return "AUTOINC+" + rev
> +        return rev
>  
>      #
>      # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
> @@ -625,18 +628,14 @@ def get_srcrev(d):
>      if not format:
>          raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
>  
> -    autoinc = False
> -    autoinc_templ = 'AUTOINC+'


Could we perhaps make use of the autoinc_tmpl is the previous hunk as
well so as to not have the AUTOINC+ string written out explicitly in
multiple places? Magic numbers and all that?


> +    seenautoinc = False
>      for scm in scms:
>          ud = urldata[scm]
>          for name in ud.names:
> -            rev = ud.method.sortable_revision(scm, ud, d, name)
> -            if rev.startswith(autoinc_templ):
> -                if not autoinc:
> -                    autoinc = True
> -                    format = "%s%s" % (autoinc_templ, format)
> -                rev = rev[len(autoinc_templ):]
> -
> +            autoinc, rev = ud.method.sortable_revision(scm, ud, d, name)
> +            if autoinc and not seenautoinc:
> +                rev = "AUTOINC+" + rev


autoinc_templ here?

Thanks,

--
Darren

> +                seenautoinc
>              format = format.replace(name, rev)
>  
>      return format
> @@ -1280,14 +1279,8 @@ class FetchMethod(object):
>              return rev
>  
>      def sortable_revision(self, url, ud, d, name):
> -        """
> -
> -        """
> -        if hasattr(self, "_sortable_revision"):
> -            return self._sortable_revision(url, ud, d)
> -
>          latest_rev = self._build_revision(url, ud, d, name)
> -        return 'AUTOINC+%s' % str(latest_rev)
> +        return True, str(latest_rev)
>  
>      def generate_revision_key(self, url, ud, d, name):
>          key = self._revision_key(url, ud, d, name)
> diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
> index 58e80c8..5d9e5f9 100644
> --- a/bitbake/lib/bb/fetch2/bzr.py
> +++ b/bitbake/lib/bb/fetch2/bzr.py
> @@ -132,12 +132,12 @@ class Bzr(FetchMethod):
>  
>          return output.strip()
>  
> -    def _sortable_revision(self, url, ud, d):
> +    def sortable_revision(self, url, ud, d, name):
>          """
>          Return a sortable revision number which in our case is the revision number
>          """
>  
> -        return self._build_revision(url, ud, d)
> +        return False, self._build_revision(url, ud, d)
>  
>      def _build_revision(self, url, ud, d):
>          return ud.revision
> diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
> index cbf929e..9a779d2 100644
> --- a/bitbake/lib/bb/fetch2/svn.py
> +++ b/bitbake/lib/bb/fetch2/svn.py
> @@ -178,12 +178,12 @@ class Svn(FetchMethod):
>  
>          return revision
>  
> -    def _sortable_revision(self, url, ud, d):
> +    def sortable_revision(self, url, ud, d, name):
>          """
>          Return a sortable revision number which in our case is the revision number
>          """
>  
> -        return self._build_revision(url, ud, d)
> +        return False, self._build_revision(url, ud, d)
>  
>      def _build_revision(self, url, ud, d):
>          return ud.revision
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


