Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1SjZmE-0006zQ-EU; Tue, 26 Jun 2012 19:42:10 +0200
Received: by wgbdr1 with SMTP id dr1so148969wgb.24
	for <multiple recipients>; Tue, 26 Jun 2012 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=UQvQUO+s7Lm90HrBVIXBgFfDMYtcekYkBzsKlcos2Os=;
	b=Gf7c9xA3x90UF0ILftThYR1iWGNWpcbCbT+k0o8EjUoJ40xCWOCq+YVz3rPiiSK2KM
	RWXdCa53lMGB5GMJyds1bDuOONss5MElCtP/0JdPEkvEaIZYkoPNOFo6+nZRnn3HHWcI
	TsCD1FmHas0A1hQu91NDNoIvOnjgVpvqTxLfrbh0i7uI+ENC6f8DIn4UXed42K2XyBUX
	Gfx6dZUrXSWfcRA4qAKmKBFmaE80fPzIDT/fMDPJA7n+64Co7PsIaEitK3kghEUkuHFI
	7WdOyBt/2XewFudcjiS4VK+NNfqBPMVQ+/fuqNXAAJ2NL1TZGG5NagRYhsK4udYXdd8D
	1pEQ==
Received: by 10.216.131.150 with SMTP id m22mr6594509wei.111.1340731878061;
	Tue, 26 Jun 2012 10:31:18 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id cl8sm1439231wib.10.2012.06.26.10.31.14
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 26 Jun 2012 10:31:16 -0700 (PDT)
Date: Tue, 26 Jun 2012 19:31:18 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120626173118.GB3169@jama.jama.net>
References: <1340289297.1640.122.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1340289297.1640.122.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core@lists.openembedded.org
Subject: (PRE)MIRRORS doesn't work with https?$:// anymore Was: [PATCH] fetch2: Add new mirror syntax to simplify mirror specifications
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
X-List-Received-Date: Tue, 26 Jun 2012 17:42:10 -0000
X-Groupsio-MsgNum: 2375
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2012 at 03:34:57PM +0100, Richard Purdie wrote:
> When writing mirror specifications, the current regexp syntax can be awkw=
ard
> and hard to get it to do what you want. For example, extracting the 'base=
name'
> of a repository:
>=20
> PREMIRRORS =3D "git://.*/([^/]+/)*([^/]*) git://somewhere.org/somedir/\\2=
;protocol=3Dfile"
>=20
> can now become:
>=20
> PREMIRRORS =3D "git://.*/.* git://somewhere.org/somedir/BASENAME;protocol=
=3Dfile"
>=20
> which is much clearer. A MIRRORNAME substitution is also added which cont=
ains
> an encoded form of both host and path. One of the problems with the exist=
ing
> regexp syntax is you couldn't access HOST information from PATH and vice-=
versa
> which is an issue this patch also addresses.

One of this fetch2 patches break https?:// in MIRRORS

It's used e.g in openembedded-core/meta/classes/mirrors.bbclass:
https?$://.*/.* http://downloads.yoctoproject.org/mirror/sources/
https?$://.*/.* http://sources.openembedded.org/

I've tested it with older bitbake in PREMIRRORS (to make log.do_fetch
log shorter) on libcap (which doesn't exist on upstream URL).

PREMIRRORS_append () {
cvs://.*/.* http://build.shr-project.org/sources/
svn://.*/.* http://build.shr-project.org/sources/
git://.*/.* http://build.shr-project.org/sources/
hg://.*/.* http://build.shr-project.org/sources/
bzr://.*/.* http://build.shr-project.org/sources/
https?$://.*/.* http://build.shr-project.org/sources/
}

bitbake d316f28ed725ff40daa8771c1aa224ac46d5b224:
DEBUG: Executing python function do_fetch
DEBUG: Executing python function base_do_fetch
DEBUG: Trying PREMIRRORS
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['cvs', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['svn', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['git', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['hg', '.*', '/.*', ''=
, '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['bzr', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['https?$', '.*', '/.*=
', '', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url http://kernel.org/pub/linux/libs/security/linux-privs/libcap=
2/libcap-2.22.tar.bz2 returning http://build.shr-project.org/sources/libcap=
-2.22.tar.bz2
NOTE: fetch http://build.shr-project.org/sources/libcap-2.22.tar.bz2
DEBUG: executing /usr/bin/env wget  -t 2 -T 30 -nv --passive-ftp --no-check=
-certificate -P /OE/shr-core/downloads 'http://build.shr-project.org/source=
s/libcap-2.22.tar.bz2'
DEBUG: Fetcher accessed the network with the command /usr/bin/env wget  -t =
2 -T 30 -nv --passive-ftp --no-check-certificate -P /OE/shr-core/downloads =
'http://build.shr-project.org/sources/libcap-2.22.tar.bz2'
DEBUG: Running export HOME=3D"/OE"; export GIT_CONFIG=3D"/OE/shr-core/tmp-e=
glibc/sysroots/x86_64-linux/etc/gitconfig"; export PATH=3D"/OE/shr-core/ope=
nembedded-core/scripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bi=
n/armv4t-oe-linux-gnueabi:/OE/shr-core/tmp-eglibc/sysroots/om-gta02/usr/bin=
/crossscripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/sbin:/OE/sh=
r-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin:/OE/shr-core/tmp-eglibc/sys=
roots/x86_64-linux/sbin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux//bin:=
/OE/shr-core/openembedded-core/scripts:/OE/bin:/usr/local/bin:/usr/bin:/bin=
:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.3"; /usr/bin/env wget  -t 2 =
-T 30 -nv --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'h=
ttp://build.shr-project.org/sources/libcap-2.22.tar.bz2'
DEBUG: Python function base_do_fetch finished
DEBUG: Python function do_fetch finished

bitbake e6ff1d4bab43fdcd8af1230f1d54615f53c1978e
DEBUG: Executing python function do_fetch
DEBUG: Executing python function base_do_fetch
DEBUG: Trying PREMIRRORS
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['cvs', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['svn', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['git', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['hg', '.*', '/.*', ''=
, '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['bzr', '.*', '/.*', '=
', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['https?$', '.*', '/.*=
', '', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: Trying Upstream
NOTE: fetch http://kernel.org/pub/linux/libs/security/linux-privs/libcap2/l=
ibcap-2.22.tar.bz2
=2E..and after trying Upstream and all MIRRORS (none will match) it fails t=
o fetch it..

Removing '$' doesn't work too:
PREMIRRORS_append () {
https?://.*/.* http://build.shr-project.org/sources/
}
DEBUG: Trying PREMIRRORS
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['https?', '.*', '/.*'=
, '', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: Trying Upstream
NOTE: fetch http://kernel.org/pub/linux/libs/security/linux-privs/libcap2/l=
ibcap-2.22.tar.bz2

Using http$ doesn't work too
EBUG: Trying PREMIRRORS
DEBUG: For url ['http', 'kernel.org', '/pub/linux/libs/security/linux-privs=
/libcap2/libcap-2.22.tar.bz2', '', '', {}] comparing ['http$', '.*', '/.*',=
 '', '', {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: Trying Upstream

And without any regexp with different PREMIRRORS for http and https it also=
 does weird things (looks like trying to resolve returned PREMIRROR again)
PREMIRRORS_append () {
http://.*/.* http://build.shr-project.org/sources/
https://.*/.* http://build.shr-project.org/https-sources/
}

changed libcap SRC_URI to https:
-SRC_URI =3D "${KERNELORG_MIRROR}/linux/libs/security/linux-privs/libcap2/$=
{BPN}-${PV}.tar.bz2"
+SRC_URI =3D "https://foo.org/linux/libs/security/linux-privs/libcap2/${BPN=
}-${PV}.tar.bz2"


DEBUG: Trying PREMIRRORS
DEBUG: For url ['https', 'foo.org', '/linux/libs/security/linux-privs/libca=
p2/libcap-2.22.tar.bz2', '', '', {}] comparing ['http', '.*', '/.*', '', ''=
, {}] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['https', 'foo.org', '/linux/libs/security/linux-privs/libca=
p2/libcap-2.22.tar.bz2', '', '', {}] comparing ['https', '.*', '/.*', '', '=
', {}] to ['http', 'build.shr-project.org', '/https-sources/', '', '', {}]
DEBUG: For url https://foo.org/linux/libs/security/linux-privs/libcap2/libc=
ap-2.22.tar.bz2 returning http://build.shr-project.org/https-sources/libcap=
-2.22.tar.bz2
DEBUG: For url ['http', 'build.shr-project.org', '/https-sources/libcap-2.2=
2.tar.bz2', '', '', {}] comparing ['http', '.*', '/.*', '', '', {}] to ['ht=
tp', 'build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url http://build.shr-project.org/https-sources/libcap-2.22.tar.b=
z2 returning http://build.shr-project.org/sources/libcap-2.22.tar.bz2
DEBUG: For url ['http', 'build.shr-project.org', '/sources/libcap-2.22.tar.=
bz2', '', '', {}] comparing ['http', '.*', '/.*', '', '', {}] to ['http', '=
build.shr-project.org', '/sources/', '', '', {}]
DEBUG: For url ['http', 'build.shr-project.org', '/sources/libcap-2.22.tar.=
bz2', '', '', {}] comparing ['https', '.*', '/.*', '', '', {}] to ['http', =
'build.shr-project.org', '/https-sources/', '', '', {}]
DEBUG: For url ['http', 'build.shr-project.org', '/https-sources/libcap-2.2=
2.tar.bz2', '', '', {}] comparing ['https', '.*', '/.*', '', '', {}] to ['h=
ttp', 'build.shr-project.org', '/https-sources/', '', '', {}]
NOTE: fetch http://build.shr-project.org/https-sources/libcap-2.22.tar.bz2
DEBUG: executing /usr/bin/env wget  -t 2 -T 30 -nv --passive-ftp --no-check=
-certificate -P /OE/shr-core/downloads 'http://build.shr-project.org/https-=
sources/libcap-2.22.tar.bz2'
DEBUG: Fetcher accessed the network with the command /usr/bin/env wget  -t =
2 -T 30 -nv --passive-ftp --no-check-certificate -P /OE/shr-core/downloads =
'http://build.shr-project.org/https-sources/libcap-2.22.tar.bz2'
DEBUG: Running export HOME=3D"/OE"; export GIT_CONFIG=3D"/OE/shr-core/tmp-e=
glibc/sysroots/x86_64-linux/etc/gitconfig"; export PATH=3D"/OE/shr-core/ope=
nembedded-core/scripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bi=
n/armv4t-oe-linux-gnueabi:/OE/shr-core/tmp-eglibc/sysroots/om-gta02/usr/bin=
/crossscripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/sbin:/OE/sh=
r-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin:/OE/shr-core/tmp-eglibc/sys=
roots/x86_64-linux/sbin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux//bin:=
/OE/shr-core/openembedded-core/scripts:/OE/bin:/usr/local/bin:/usr/bin:/bin=
:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.3"; /usr/bin/env wget  -t 2 =
-T 30 -nv --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'h=
ttp://build.shr-project.org/https-sources/libcap-2.22.tar.bz2'
DEBUG: Mirror fetch failure for url http://build.shr-project.org/https-sour=
ces/libcap-2.22.tar.bz2 (original url: https://foo.org/linux/libs/security/=
linux-privs/libcap2/libcap-2.22.tar.bz2)
DEBUG: Fetcher failure: Fetch command export HOME=3D"/OE"; export GIT_CONFI=
G=3D"/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/etc/gitconfig"; export P=
ATH=3D"/OE/shr-core/openembedded-core/scripts:/OE/shr-core/tmp-eglibc/sysro=
ots/x86_64-linux/usr/bin/armv4t-oe-linux-gnueabi:/OE/shr-core/tmp-eglibc/sy=
sroots/om-gta02/usr/bin/crossscripts:/OE/shr-core/tmp-eglibc/sysroots/x86_6=
4-linux/usr/sbin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin:/OE/=
shr-core/tmp-eglibc/sysroots/x86_64-linux/sbin:/OE/shr-core/tmp-eglibc/sysr=
oots/x86_64-linux//bin:/OE/shr-core/openembedded-core/scripts:/OE/bin:/usr/=
local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.3"; /=
usr/bin/env wget  -t 2 -T 30 -nv --passive-ftp --no-check-certificate -P /O=
E/shr-core/downloads 'http://build.shr-project.org/https-sources/libcap-2.2=
2.tar.bz2' failed with exit code 8, output:
STDOUT:
STDERR: http://build.shr-project.org/https-sources/libcap-2.22.tar.bz2:
2012-06-26 19:23:37 ERROR 404: Not Found.

NOTE: fetch http://build.shr-project.org/sources/libcap-2.22.tar.bz2
DEBUG: executing /usr/bin/env wget  -t 2 -T 30 -nv --passive-ftp --no-check=
-certificate -P /OE/shr-core/downloads 'http://build.shr-project.org/source=
s/libcap-2.22.tar.bz2'
DEBUG: Fetcher accessed the network with the command /usr/bin/env wget  -t =
2 -T 30 -nv --passive-ftp --no-check-certificate -P /OE/shr-core/downloads =
'http://build.shr-project.org/sources/libcap-2.22.tar.bz2'
DEBUG: Running export HOME=3D"/OE"; export GIT_CONFIG=3D"/OE/shr-core/tmp-e=
glibc/sysroots/x86_64-linux/etc/gitconfig"; export PATH=3D"/OE/shr-core/ope=
nembedded-core/scripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bi=
n/armv4t-oe-linux-gnueabi:/OE/shr-core/tmp-eglibc/sysroots/om-gta02/usr/bin=
/crossscripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/sbin:/OE/sh=
r-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin:/OE/shr-core/tmp-eglibc/sys=
roots/x86_64-linux/sbin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux//bin:=
/OE/shr-core/openembedded-core/scripts:/OE/bin:/usr/local/bin:/usr/bin:/bin=
:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.3"; /usr/bin/env wget  -t 2 =
-T 30 -nv --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'h=
ttp://build.shr-project.org/sources/libcap-2.22.tar.bz2'
DEBUG: Python function base_do_fetch finished
DEBUG: Python function do_fetch finished


Cheers,
>=20
> Tests for the new syntax are also added.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
> index 1b99a0f..e6f55f8 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -182,7 +182,7 @@ def encodeurl(decoded):
> =20
>      return url
> =20
> -def uri_replace(ud, uri_find, uri_replace, d):
> +def uri_replace(ud, uri_find, uri_replace, replacements, d):
>      if not ud.url or not uri_find or not uri_replace:
>          logger.error("uri_replace: passed an undefined value, not replac=
ing")
>          return None
> @@ -213,6 +213,8 @@ def uri_replace(ud, uri_find, uri_replace, d):
>              if not uri_replace_decoded[loc]:
>                  result_decoded[loc] =3D ""   =20
>              else:
> +                for k in replacements:
> +                    uri_replace_decoded[loc] =3D uri_replace_decoded[loc=
].replace(k, replacements[k])
>                  #bb.note("%s %s %s" % (i, uri_replace_decoded[loc], uri_=
decoded[loc]))
>                  result_decoded[loc] =3D re.sub(i, uri_replace_decoded[lo=
c], uri_decoded[loc])
>              if loc =3D=3D 2:
> @@ -485,13 +487,20 @@ def build_mirroruris(origud, mirrors, ld):
>      uris =3D []
>      uds =3D []
> =20
> +    replacements =3D {}
> +    replacements["TYPE"] =3D origud.type
> +    replacements["HOST"] =3D origud.host
> +    replacements["PATH"] =3D origud.path
> +    replacements["BASENAME"] =3D origud.path.split("/")[-1]
> +    replacements["MIRRORNAME"] =3D origud.host.replace(':','.') + origud=
=2Epath.replace('/', '.')
> +
>      def adduri(uri, ud, uris, uds):
>          for line in mirrors:
>              try:
>                  (find, replace) =3D line
>              except ValueError:
>                  continue
> -            newuri =3D uri_replace(ud, find, replace, ld)
> +            newuri =3D uri_replace(ud, find, replace, replacements, ld)
>              if not newuri or newuri in uris or newuri =3D=3D origud.url:
>                  continue
>              uris.append(newuri)
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
> index 9961343..1477fab 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -48,7 +48,14 @@ class FetcherTest(unittest.TestCase):
>          ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2=
", "http://www.apache.org/dist", "http://archive.apache.org/dist")
>              : "http://archive.apache.org/dist/subversion/subversion-1.7.=
1.tar.bz2",
>          ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2=
", "http://.*/.*", "file:///somepath/downloads/")
> -            : "file:///somepath/downloads/subversion-1.7.1.tar.bz2"
> +            : "file:///somepath/downloads/subversion-1.7.1.tar.bz2",
> +        ("git://git.invalid.infradead.org/mtd-utils.git;tag=3D1234567890=
123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedi=
r/BASENAME;protocol=3Dhttp")=20
> +            : "git://somewhere.org/somedir/mtd-utils.git;tag=3D123456789=
0123456789012345678901234567890;protocol=3Dhttp",=20
> +        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=3D123456=
7890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/so=
medir/BASENAME;protocol=3Dhttp")=20
> +            : "git://somewhere.org/somedir/mtd-utils.git;tag=3D123456789=
0123456789012345678901234567890;protocol=3Dhttp",=20
> +        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=3D123456=
7890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/so=
medir/MIRRORNAME;protocol=3Dhttp")=20
> +            : "git://somewhere.org/somedir/git.invalid.infradead.org.foo=
=2Emtd-utils.git;tag=3D1234567890123456789012345678901234567890;protocol=3D=
http",=20
> +
>          #Renaming files doesn't work
>          #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http:/=
/somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/some=
dir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3=
=2E4.tar.gz"
>          #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/12=
34/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
> @@ -143,8 +150,9 @@ class FetcherTest(unittest.TestCase):
>          for k, v in self.replaceuris.items():
>              ud =3D bb.fetch.FetchData(k[0], self.d)
>              ud.setup_localpath(self.d)
> -            newuris =3D bb.fetch2.uri_replace(ud, k[1], k[2], self.d)
> -            self.assertEqual(newuris, v)
> +            mirrors =3D bb.fetch2.mirror_from_string("%s %s" % (k[1], k[=
2]))
> +            newuris, uds =3D bb.fetch2.build_mirroruris(ud, mirrors, sel=
f.d)
> +            self.assertEqual(newuris, [v])
> =20
>      def test_urilist1(self):
>          fetcher =3D bb.fetch.FetchData("http://downloads.yoctoproject.or=
g/releases/bitbake/bitbake-1.0.tar.gz", self.d)
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/p8eYACgkQN1Ujt2V2gBz++QCdFM7/iUhg+JQUYDcbVQVhgnuD
4JcAoIzBgwqSFBy1T2bRxw0HOpW3yE+F
=KdXH
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
