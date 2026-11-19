Subject: gitsm fetcher fails when `PREMIRRORS_ONLY` is set
To: bitbake-devel@lists.openembedded.org
From: tiago.mlb.vasconcelos@gmail.com
X-Originating-Location: Porto, PT (178.166.76.28)
X-Originating-Platform: Windows Chrome 157
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 06:13:03 -0800
Message-ID: <9Kec.1795097583791318314.gZXu@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="RsQBOqB49sl0C4J0qllQ"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 14:13:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20461

--RsQBOqB49sl0C4J0qllQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I have encountered a gitsm submodule fetch failure that appears to be
related to the following change:

https://lists.openembedded.org/g/bitbake-devel/message/17506

This change prevents Git fetcher to silently contact upstream
despite BB_FETCH_PREMIRRORONLY being enabled.

However, for gitsm, this datastore is also passed to the nested submodule
Fetch. The submodule therefore inherits BB_NO_NETWORK =3D "1", blocking its
HTTP PREMIRROR download, even though the parent repository was downloaded f=
rom
the same PREMIRROR:

The resulting error is:

gitsm: submodule download failed: NetworkAccess Network access disabled
through BB_NO_NETWORK (or set indirectly due to use of
BB_FETCH_PREMIRRORONLY) but access requested with command wget ...

I have considered the following approaches. The snippets below are
illustrative examples, not complete patches.

*=20

Reset BB_NO_NETWORK in gitsm's download_submodule() at:
https://git.openembedded.org/bitbake/tree/lib/bb/fetch/gitsm.py#n212
Before creating the nested Fetch instance:

if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
   d.setVar("BB_NO_NETWORK", "0")

try:
   newfetch =3D Fetch([url], d, cache=3DFalse)
   newfetch.download()
except Exception as e:
   logger.error(
       'gitsm: submodule download failed: %s %s'
       % (type(e).__name__, str(e))
   )
   raise

This allows the submodule to access the HTTP PREMIRROR.

*=20

Scope the restriction more narrowly:

https://git.openembedded.org/bitbake/tree/lib/bb/fetch/__init__.py#n1160

Instead of passing the modified BB_NO_NETWORK =3D "1" value to nested
submodule fetches, apply the restriction specifically to the Git
operations.

*=20

Preserve and restore the original BB_NO_NETWORK value at:
https://git.openembedded.org/bitbake/tree/lib/bb/fetch/__init__.py#n1157

In try_mirror_url(), preserve the original value before applying
the temporary restriction:

network =3D ld.getVarFlag("BB_NO_NETWORK", "original_bb_no_network")
if network is None:
   network =3D ld.getVar("BB_NO_NETWORK") or "0"
   ld.setVarFlag(
       "BB_NO_NETWORK", "original_bb_no_network", network
   )

Restore that value before downloading from the mirror:

if not verify_donestamp(ud, ld, origud) or ud.method.need_update(ud, ld):
   if bb.utils.to_boolean(ld.getVar("BB_FETCH_PREMIRRORONLY")):
       ld.setVar("BB_NO_NETWORK", network)

   ud.method.download(ud, ld)
   if hasattr(ud.method, "build_mirror_data"):
       ud.method.build_mirror_data(ud, ld)

The intention is to distinguish the user's original network policy
from the temporary restriction applied during mirror processing.

The intended behaviour is to allow both the parent repository and its
submodules to be fetched from configured PREMIRRORS, without permitting
upstream access.

I would appreciate your thoughts on these approaches.

Best regards,
Tiago Vasconcelos

--RsQBOqB49sl0C4J0qllQ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div><!-- obsidian -->
<p>Hi all,</p>
<p>I have encountered a gitsm submodule fetch failure that appears to be<br=
 />related to the following change:</p>
<p><a class=3D"external-link" href=3D"https://lists.openembedded.org/g/bitb=
ake-devel/message/17506" target=3D"_blank" rel=3D"noopener nofollow">https:=
//lists.openembedded.org/g/bitbake-devel/message/17506</a></p>
<p>This change prevents Git fetcher to silently contact upstream<br />despi=
te BB_FETCH_PREMIRRORONLY being enabled.</p>
<p>However, for gitsm, this datastore is also passed to the nested submodul=
e<br />Fetch. The submodule therefore inherits BB_NO_NETWORK =3D "1", block=
ing its<br />HTTP PREMIRROR download, even though the parent repository was=
 downloaded from<br />the same PREMIRROR:</p>
<p>The resulting error is:</p>
<pre><code>gitsm: submodule download failed: NetworkAccess Network access d=
isabled
through BB_NO_NETWORK (or set indirectly due to use of
BB_FETCH_PREMIRRORONLY) but access requested with command wget ...
</code></pre>
<p>I have considered the following approaches. The snippets below are<br />=
illustrative examples, not complete patches.</p>
<ol>
<li>
<p>Reset BB_NO_NETWORK in gitsm's download_submodule() at:<br /><a class=3D=
"external-link" href=3D"https://git.openembedded.org/bitbake/tree/lib/bb/fe=
tch/gitsm.py#n212" target=3D"_blank" rel=3D"noopener nofollow">https://git.=
openembedded.org/bitbake/tree/lib/bb/fetch/gitsm.py#n212</a><br />Before cr=
eating the nested Fetch instance:</p>
<pre><code>if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
    d.setVar("BB_NO_NETWORK", "0")

try:
    newfetch =3D Fetch([url], d, cache=3DFalse)
    newfetch.download()
except Exception as e:
    logger.error(
        'gitsm: submodule download failed: %s %s'
        % (type(e).__name__, str(e))
    )
    raise
</code></pre>
<p>This allows the submodule to access the HTTP PREMIRROR.</p>
</li>
<li>
<p>Scope the restriction more narrowly:</p>
<p>https://git.openembedded.org/bitbake/tree/lib/bb/fetch/__init__.py#n1160=
</p>
<p>Instead of passing the modified BB_NO_NETWORK =3D "1" value to nested<br=
 />submodule fetches, apply the restriction specifically to the Git<br />op=
erations.</p>
</li>
<li>
<p>Preserve and restore the original BB_NO_NETWORK value at:<br /><a class=
=3D"external-link" href=3D"https://git.openembedded.org/bitbake/tree/lib/bb=
/fetch/__init__.py#n1157" target=3D"_blank" rel=3D"noopener nofollow">https=
://git.openembedded.org/bitbake/tree/lib/bb/fetch/__init__.py#n1157</a></p>
<p>In try_mirror_url(), preserve the original value before applying<br />th=
e temporary restriction:</p>
<pre><code>network =3D ld.getVarFlag("BB_NO_NETWORK", "original_bb_no_netwo=
rk")
if network is None:
    network =3D ld.getVar("BB_NO_NETWORK") or "0"
    ld.setVarFlag(
        "BB_NO_NETWORK", "original_bb_no_network", network
    )
</code></pre>
<p>Restore that value before downloading from the mirror:</p>
<pre><code>if not verify_donestamp(ud, ld, origud) or ud.method.need_update=
(ud, ld):
    if bb.utils.to_boolean(ld.getVar("BB_FETCH_PREMIRRORONLY")):
        ld.setVar("BB_NO_NETWORK", network)

    ud.method.download(ud, ld)
    if hasattr(ud.method, "build_mirror_data"):
        ud.method.build_mirror_data(ud, ld)
</code></pre>
<p>The intention is to distinguish the user's original network policy<br />=
from the temporary restriction applied during mirror processing.</p>
</li>
</ol>
<p>The intended behaviour is to allow both the parent repository and its<br=
 />submodules to be fetched from configured PREMIRRORS, without permitting<=
br />upstream access.</p>
<p>I would appreciate your thoughts on these approaches.</p>
<p>Best regards,<br />Tiago Vasconcelos</p>
</div>

--RsQBOqB49sl0C4J0qllQ--
