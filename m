Return-Path: <sgw@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4DD2960657
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 22:27:34 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 22 May 2013 15:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,724,1363158000"; d="scan'208";a="318034403"
Received: from unknown (HELO [10.255.12.171]) ([10.255.12.171])
	by orsmga001.jf.intel.com with ESMTP; 22 May 2013 15:27:29 -0700
Message-ID: <519D4651.2030506@linux.intel.com>
Date: Wed, 22 May 2013 15:27:29 -0700
From: Saul Wold <sgw@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1368958678.32727.92.camel@ted>
In-Reply-To: <1368958678.32727.92.camel@ted>
Cc: "Hart, Darren" <darren.hart@intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Clean up sortable_revision
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 May 2013 22:27:34 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
>           raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
>
>       if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
> -        return urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
> +        autoinc, rev = urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
> +        if autoinc:
> +            return "AUTOINC+" + rev
> +        return rev
>
>       #
>       # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
> @@ -625,18 +628,14 @@ def get_srcrev(d):
>       if not format:
>           raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
>
> -    autoinc = False
> -    autoinc_templ = 'AUTOINC+'
> +    seenautoinc = False
>       for scm in scms:
>           ud = urldata[scm]
>           for name in ud.names:
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
> +                seenautoinc
Should this be: seenautoinc = True  ??

Sau!

>               format = format.replace(name, rev)
>
>       return format
> @@ -1280,14 +1279,8 @@ class FetchMethod(object):
>               return rev
>
>       def sortable_revision(self, url, ud, d, name):
> -        """
> -
> -        """
> -        if hasattr(self, "_sortable_revision"):
> -            return self._sortable_revision(url, ud, d)
> -
>           latest_rev = self._build_revision(url, ud, d, name)
> -        return 'AUTOINC+%s' % str(latest_rev)
> +        return True, str(latest_rev)
>
>       def generate_revision_key(self, url, ud, d, name):
>           key = self._revision_key(url, ud, d, name)
> diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
> index 58e80c8..5d9e5f9 100644
> --- a/bitbake/lib/bb/fetch2/bzr.py
> +++ b/bitbake/lib/bb/fetch2/bzr.py
> @@ -132,12 +132,12 @@ class Bzr(FetchMethod):
>
>           return output.strip()
>
> -    def _sortable_revision(self, url, ud, d):
> +    def sortable_revision(self, url, ud, d, name):
>           """
>           Return a sortable revision number which in our case is the revision number
>           """
>
> -        return self._build_revision(url, ud, d)
> +        return False, self._build_revision(url, ud, d)
>
>       def _build_revision(self, url, ud, d):
>           return ud.revision
> diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
> index cbf929e..9a779d2 100644
> --- a/bitbake/lib/bb/fetch2/svn.py
> +++ b/bitbake/lib/bb/fetch2/svn.py
> @@ -178,12 +178,12 @@ class Svn(FetchMethod):
>
>           return revision
>
> -    def _sortable_revision(self, url, ud, d):
> +    def sortable_revision(self, url, ud, d, name):
>           """
>           Return a sortable revision number which in our case is the revision number
>           """
>
> -        return self._build_revision(url, ud, d)
> +        return False, self._build_revision(url, ud, d)
>
>       def _build_revision(self, url, ud, d):
>           return ud.revision
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>

