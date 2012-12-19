Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TlOGw-0005kk-Qc
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Dec 2012 19:22:07 +0100
Received: by mail-pb0-f53.google.com with SMTP id jt11so1380292pbb.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2012 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=dH2JKVzbTwnhJkbO5z42BsF5uZYi9VRjD+Q2GBkHA6Y=;
	b=w4IDvH4o9iUdmZfEMDhbUv0yu3jVsf/pIeEXUlU50t9kuxgx52d0BO6r0+3/Xa5i8H
	ZU6lA30g4ZdUSrDdkRzjuR8uEAYvZLBgp9ymj7AU2ZkRpWGthQ6NNKNZcAx0WWB8OoCS
	kRavu7/SrZ+AFKf0W1Ee8NloAPEPd2ogNzxp7n/TWvYRqfh4GP7Z6G3bQOMen1aX4Jmp
	U89AzzvrxLaGS5ZY2EbMKH1wz6p0AbCqq4GoWGvOMLlt6yoISR0ebvVjKHQU0Rs06cuL
	KXGYAl+h/G1G9Jkei+2oL7u0Gt6sA/5rJ3meKsyCKi8tKskY/yLQ6X9WFhMt7SnrW4HZ
	ATTw==
X-Received: by 10.66.82.33 with SMTP id f1mr19575474pay.11.1355940406683;
	Wed, 19 Dec 2012 10:06:46 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id v2sm3797465paz.36.2012.12.19.10.06.43
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 19 Dec 2012 10:06:45 -0800 (PST)
Date: Wed, 19 Dec 2012 19:06:42 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Saul Wold <sgw@linux.intel.com>
Message-ID: <20121219180642.GD14543@jama.palm1.palmone.com>
References: <1354697906-19696-1-git-send-email-constantinx.musca@intel.com>
	<50D1512F.9030302@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <50D1512F.9030302@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org,
	Constantin Musca <constantinx.musca@intel.com>
Subject: Re: [PATCH 1/2] fetch2: remove localcount and use AUTOINC instead
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
X-List-Received-Date: Wed, 19 Dec 2012 18:22:37 -0000
X-Groupsio-MsgNum: 3053
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline

--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2012 at 09:31:27PM -0800, Saul Wold wrote:
> On 12/05/2012 12:58 AM, Constantin Musca wrote:
> > - do not use the BB_URI_LOCALCOUNT database for computing revision
> > incremental numbers anymore
> > - sortable_revision now generates "AUTOINC+${latest_rev}"
> > - use one incrementing value rather than several
> > - PV becomes 0.1+gitAUTOINC+deadbeefdecafbad_decafbaddeadbeef
> > - remove all localcount code and simplify the fetcher
> > - this patch addresses the following proposal:
> > http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-November/003878=
=2Ehtml
> >
> > Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
> > ---
> >   bitbake/lib/bb/fetch2/__init__.py | 55 +++++++-----------------------=
---------
> >   bitbake/lib/bb/fetch2/git.py      | 39 ++-------------------------
> >   2 files changed, 11 insertions(+), 83 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/=
__init__.py
> > index 81964f1..150dc3c 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -422,10 +422,18 @@ def get_srcrev(d):
> >       if not format:
> >           raise FetchError("The SRCREV_FORMAT variable must be set when=
 multiple SCMs are used.")
> >
> > +    autoinc =3D False
> > +    autoinc_templ =3D 'AUTOINC+'
>=20
> Somethings not right about this, when I rebuild the following was created:
>=20
> 3.4.20+git5+6737e890fff2a423fbb022ab1f7f82ef187fd8b1_3+b13bef6377719a4882=
93af196236cc290566fad3-r4.3
> 3.4.20+gitAUTOINC+6737e890fff2a423fbb022ab1f7f82ef187fd8b1_b13bef6377719a=
488293af196236cc290566fad3-r4.3

I see this too, but I think it's expected.. AUTOINC is used in PV and
it's replaced by some number only in PKGV (not shown in bitbake log).

Check filename of resulting package.

Cheers,

> Something is not converting correctly.
>=20
> Sau!
>=20
>=20
> >       for scm in scms:
> >           ud =3D urldata[scm]
> >           for name in ud.names:
> >               rev =3D ud.method.sortable_revision(scm, ud, d, name)
> > +            if rev.startswith(autoinc_templ):
> > +                if not autoinc:
> > +                    autoinc =3D True
> > +                    format =3D "%s%s" % (autoinc_templ, format)
> > +                rev =3D rev[len(autoinc_templ):]
> > +
> >               format =3D format.replace(name, rev)
> >
> >       return format
> > @@ -1036,23 +1044,6 @@ class FetchMethod(object):
> >           logger.info("URL %s could not be checked for status since no =
method exists.", url)
> >           return True
> >
> > -    def localcount_internal_helper(ud, d, name):
> > -        """
> > -        Return:
> > -            a) a locked localcount if specified
> > -            b) None otherwise
> > -        """
> > -
> > -        localcount =3D None
> > -        if name !=3D '':
> > -            pn =3D d.getVar("PN", True)
> > -            localcount =3D d.getVar("LOCALCOUNT_" + name, True)
> > -        if not localcount:
> > -            localcount =3D d.getVar("LOCALCOUNT", True)
> > -        return localcount
> > -
> > -    localcount_internal_helper =3D staticmethod(localcount_internal_he=
lper)
> > -
> >       def latest_revision(self, url, ud, d, name):
> >           """
> >           Look in the cache for the latest revision, if not present ask=
 the SCM.
> > @@ -1075,36 +1066,8 @@ class FetchMethod(object):
> >           if hasattr(self, "_sortable_revision"):
> >               return self._sortable_revision(url, ud, d)
> >
> > -        localcounts =3D bb.persist_data.persist('BB_URI_LOCALCOUNT', d)
> > -        key =3D self.generate_revision_key(url, ud, d, name)
> > -
> >           latest_rev =3D self._build_revision(url, ud, d, name)
> > -        last_rev =3D localcounts.get(key + '_rev')
> > -        uselocalcount =3D d.getVar("BB_LOCALCOUNT_OVERRIDE", True) or =
False
> > -        count =3D None
> > -        if uselocalcount:
> > -            count =3D FetchMethod.localcount_internal_helper(ud, d, na=
me)
> > -        if count is None:
> > -            count =3D localcounts.get(key + '_count') or "0"
> > -
> > -        if last_rev =3D=3D latest_rev:
> > -            return str(count + "+" + latest_rev)
> > -
> > -        buildindex_provided =3D hasattr(self, "_sortable_buildindex")
> > -        if buildindex_provided:
> > -            count =3D self._sortable_buildindex(url, ud, d, latest_rev)
> > -
> > -        if count is None:
> > -            count =3D "0"
> > -        elif uselocalcount or buildindex_provided:
> > -            count =3D str(count)
> > -        else:
> > -            count =3D str(int(count) + 1)
> > -
> > -        localcounts[key + '_rev'] =3D latest_rev
> > -        localcounts[key + '_count'] =3D count
> > -
> > -        return str(count + "+" + latest_rev)
> > +        return 'AUTOINC+%s' % str(latest_rev)
> >
> >       def generate_revision_key(self, url, ud, d, name):
> >           key =3D self._revision_key(url, ud, d, name)
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > index 0fd0b2f..2a8a727 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > @@ -71,11 +71,8 @@ from   bb.fetch2 import logger
> >   class Git(FetchMethod):
> >       """Class to fetch a module or modules from git repositories"""
> >       def init(self, d):
> > -        #
> > -        # Only enable _sortable revision if the key is set
> > -        #
> > -        if d.getVar("BB_GIT_CLONE_FOR_SRCREV", True):
> > -            self._sortable_buildindex =3D self._sortable_buildindex_di=
sabled
> > +        pass
> > +
> >       def supports(self, url, ud, d):
> >           """
> >           Check to see if a given url can be fetched with git.
> > @@ -316,38 +313,6 @@ class Git(FetchMethod):
> >       def _build_revision(self, url, ud, d, name):
> >           return ud.revisions[name]
> >
> > -    def _sortable_buildindex_disabled(self, url, ud, d, rev):
> > -        """
> > -        Return a suitable buildindex for the revision specified. This =
is done by counting revisions
> > -        using "git rev-list" which may or may not work in different ci=
rcumstances.
> > -        """
> > -
> > -        cwd =3D os.getcwd()
> > -
> > -        # Check if we have the rev already
> > -
> > -        if not os.path.exists(ud.clonedir):
> > -            logger.debug(1, "GIT repository for %s does not exist in %=
s.  \
> > -                          Downloading.", url, ud.clonedir)
> > -            self.download(None, ud, d)
> > -            if not os.path.exists(ud.clonedir):
> > -                logger.error("GIT repository for %s does not exist in =
%s after \
> > -                             download. Cannot get sortable buildnumber=
, using \
> > -                             old value", url, ud.clonedir)
> > -                return None
> > -
> > -
> > -        os.chdir(ud.clonedir)
> > -        if not self._contains_ref(rev, d):
> > -            self.download(None, ud, d)
> > -
> > -        output =3D runfetchcmd("%s rev-list %s -- 2> /dev/null | wc -l=
" % (ud.basecmd, rev), d, quiet=3DTrue)
> > -        os.chdir(cwd)
> > -
> > -        buildindex =3D "%s" % output.split()[0]
> > -        logger.debug(1, "GIT repository for %s in %s is returning %s r=
evisions in rev-list before %s", url, ud.clonedir, buildindex, rev)
> > -        return buildindex
> > -
> >       def checkstatus(self, uri, ud, d):
> >           fetchcmd =3D "%s ls-remote %s" % (ud.basecmd, uri)
> >           try:
> >
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDSAjIACgkQN1Ujt2V2gBwrqwCfa4ttg/+L8i4rVoWfM78zRrVc
KNAAniF4PbJPY9YfJCNsuBRofMfTE0QB
=4E3o
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
