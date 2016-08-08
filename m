Return-Path: <tobias.hagelborn@axis.com>
X-Greylist: delayed 538 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 08 Aug 2016 08:43:42 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3BC6A7706E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 08:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id EAEE9180E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 10:34:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id sOvHQZSVMyH4 for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 10:34:42 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 1F28118074
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 10:34:42 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 0376F1B9D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 10:34:42 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id ECAEA1B88
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 10:34:41 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by thoth.se.axis.com (Postfix) with ESMTP id EACD834C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 10:34:41 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Mon, 8 Aug 2016 10:34:41 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Mon, 8 Aug 2016 10:34:41 +0200
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
Thread-Index: AQHR2F1GRHAIjfzM60eL99EqiTAysA==
Date: Mon, 8 Aug 2016 08:34:41 +0000
Message-ID: <1470645281559.73326@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Mon, 08 Aug 2016 08:43:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=0A=
Change made to enable building offline also with git tag references=0A=
in SRC_URI.=0A=
=0A=
If BB_NO_NETWORK is set, fallback to search for tags and revisions=0A=
in local DL_DIR / GITDIR in order to avoid network access.=0A=
=0A=
Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>=0A=
---=0A=
=A0bitbake/lib/bb/fetch2/git.py | 36 ++++++++++++++++++++++++------------=
=0A=
=A01 file changed, 24 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py=0A=
index 9bd87ad..0c08a3c 100644=0A=
--- a/bitbake/lib/bb/fetch2/git.py=0A=
+++ b/bitbake/lib/bb/fetch2/git.py=0A=
@@ -131,12 +131,6 @@ class Git(FetchMethod):=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 ud.setup_revisons(d)=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0=A0 for name in ud.names:=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Ensure anything that doesn't look like=
 a sha256 checksum/revision is translated into one=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if not ud.revisions[name] or len(ud.revi=
sions[name]) !=3D 40=A0 or (False in [c in "abcdef0123456789" for c in ud.r=
evisions[name]]):=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ud.revisions[name]:=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ud.unresolvedrev=
[name] =3D ud.revisions[name]=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ud.revisions[name] =3D self.=
latest_revision(ud, d, name)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 gitsrcname =3D '%s%s' % (ud.host.replace(':', '.')=
, ud.path.replace('/', '.').replace('*', '.'))=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if gitsrcname.startswith('.'):=0A=
@@ -156,6 +150,13 @@ class Git(FetchMethod):=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 ud.localfile =3D ud.clonedir=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 for name in ud.names:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Ensure anything that doesn't look like=
 a sha256 checksum/revision is translated into one=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if not ud.revisions[name] or len(ud.revi=
sions[name]) !=3D 40=A0 or (False in [c in "abcdef0123456789" for c in ud.r=
evisions[name]]):=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ud.revisions[name]:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ud.unresolvedrev=
[name] =3D ud.revisions[name]=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ud.revisions[name] =3D self.=
latest_revision(ud, d, name)=0A=
+=0A=
=A0=A0=A0=A0 def localpath(self, ud, d):=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return ud.clonedir=0A=
=A0=0A=
@@ -345,12 +346,23 @@ class Git(FetchMethod):=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 repourl =3D self._get_repo_url(ud)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D "%s ls-remote %s %s" % \=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ud.basecmd, repourl, search)=0A=
-=A0=A0=A0=A0=A0=A0=A0 if ud.proto.lower() !=3D 'file':=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bb.fetch2.check_network_access(d, cmd)=
=0A=
-=A0=A0=A0=A0=A0=A0=A0 output =3D runfetchcmd(cmd, d, True)=0A=
-=A0=A0=A0=A0=A0=A0=A0 if not output:=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise bb.fetch2.FetchError("The command =
%s gave empty output unexpectedly" % cmd, ud.url)=0A=
-=A0=A0=A0=A0=A0=A0=A0 return output=0A=
+=A0=A0=A0=A0=A0=A0=A0 try:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ud.proto.lower() !=3D 'file':=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bb.fetch2.check_network_acce=
ss(d, cmd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output =3D runfetchcmd(cmd, d, True)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if not output:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise bb.fetch2.FetchError("=
The command %s gave empty output unexpectedly" % cmd, ud.url)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return output=0A=
+=A0=A0=A0=A0=A0=A0=A0 except bb.fetch2.NetworkAccess as exc:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Fallback to local DL_DIR/GITDIR if BB_=
NO_NETWORK is set=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D "%s ls-remote %s://%s %s" % \=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ud.basecmd, 'file', s=
elf.localpath(ud, d), search)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output =3D runfetchcmd(cmd, d, True)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if output.split() =3D=3D []:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bb.warn('failed: ', cmd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if not output:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise bb.fetch2.FetchError("=
The command %s gave empty output unexpectedly" % cmd, ud.url)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return output=0A=
=A0=0A=
=A0=A0=A0=A0 def _latest_revision(self, ud, d, name):=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 """=0A=
-- =0A=
2.1.4=0A=

