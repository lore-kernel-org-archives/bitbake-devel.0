Return-Path: <andre.draszik@gmail.com>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 9F7437F98C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 14:21:32 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id e6so6707788wrw.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 06:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2WfImjGEorX1XcM4KLFfC3HDpp1pRBdEPoxeOYgN2XI=;
	b=iJqdnHyXexH0BFVDkKWKlXcYH5ULiPtcX+9QmAhyC40F33FEknWEHtQGb1jFqEFCfP
	Kcwp0v6JYFtDYQfQvhOSwb/LCRAV55aKpg++l3+GqkUzNOiPN3eFZ023B9McOWFDlrPQ
	dSB57/DdzUQVv+A7kZDmSsqqbshhdHEnI7qTY0kiDoiOK18dE6JnlgOFiyQRLTbNn395
	PuKuA5D8PIsUZMccGjRt2VkJDBjXxH7FiGJmyYMYEJcgSqYsTSuRmvARB8UVs28qgkYg
	GHoQjhQA50au3Q1AtcTnb2+OFy76B4p7aY142UQPFQvuXMSJVWJJdI/6/Na5u/LK1Ga9
	VoPw==
X-Gm-Message-State: APjAAAX929XBw4ipKvb5aIU02837mqwSp68eiKvQ7zOA1l3FKHDgmnPI
	Qz4OYaexZnSKne9oBkV4oKJIXTXC
X-Google-Smtp-Source: APXvYqwaMrZA9UhvyKyhpsKzpGT6svt/xxJx0IQEOct1tddUR6AvWLLOILR4hYv4pzwIT+UdQp/Sng==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr8991767wrc.150.1573741292830; 
	Thu, 14 Nov 2019 06:21:32 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	c24sm9316355wrb.27.2019.11.14.06.21.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 14 Nov 2019 06:21:32 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2019 14:21:31 +0000
Message-Id: <20191114142131.29829-1-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Subject: [master][PATCH] fetch2/wget: support releases from private github repositories
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
X-List-Received-Date: Thu, 14 Nov 2019 14:21:32 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The wget / http fetcher currently doesn't support fetching
assets attached to releases on private GitHub repositories,
i.e. release artefacts like
    https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt

Those are special, in that HTTP basic auth is not used / possible
on the URL as seen in the GitHub UI, but instead the GitHub API
must be used for downloading (which does support HTTP basic auth)
where the URL will be different.

To be able to access the GitHub API, opportunistic authentication
(auth-no-challenge) needs to be enabled. Then the API needs to
be queried for the real URL of the file to be downloaded, and
finally application/octet-stream must be specified explicitly.

Note that there is a slight difference in the location of the
REST API endpoints between GitHub.com and GitHub Enterprise.

    https://developer.github.com/v3/repos/releases/
    https://developer.github.com/enterprise/2.19/v3/enterprise-admin/

As it's impossible to determine if a repository is on GitHub
or not (considering GitHub Enterprise), and even more so if a
repository is private or not, a new flag is introduced that
should be set to "1" - "github_private_asset", e.g.

    SRC_URI = "https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt;github_private_asset=1"

Some notes:
* --auth-no-challenge is added unconditionally because we know
  username / password will definitely be needed, and they are
  likely to be specified in ~/.netrc, rather than in the recipe
* the release information returned looks sth like:
[
    {
        ...
        "assets": [
            {
                ...
                "browser_download_url": "https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt",
                "url": "https://api.github.com/repos/<user>/<project>/releases/assets/16146291",
                ...
            },
            ...
        ],
        ...
    },
    ...
]
  hence we need to pass -O to wget to explicitly download using
  the original name
* this has been tested with github.com and GitHub Enterprise on
  private repositories, with and without PREMIRRORS

Signed-off-by: André Draszik <git@andred.net>
---
 lib/bb/fetch2/wget.py | 90 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 725586d2..90aa9b19 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -4,6 +4,12 @@ BitBake 'Fetch' implementations
 Classes for obtaining upstream sources for the
 BitBake build tools.
 
+Supported SRC_URI options are:
+
+- github_private_asset
+   Whether or not the URI is pointing to a release artefact
+   in a private GitHub repository. The default is no.
+
 """
 
 # Copyright (C) 2003, 2004  Chris Larson
@@ -23,11 +29,13 @@ import bb.progress
 import socket
 import http.client
 import urllib.request, urllib.parse, urllib.error
+import json
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import FetchConnectionCache
+from   bb.fetch2 import uri_replace
 from   bb.utils import export_proxies
 from   bs4 import BeautifulSoup
 from   bs4 import SoupStrainer
@@ -78,6 +86,8 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
+        ud.github_private = ud.parm.get("github_private_asset","0") == "1"
+
         self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
 
     def _runwget(self, ud, d, command, quiet, workdir=None):
@@ -93,15 +103,85 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd
 
-        if 'downloadfilename' in ud.parm:
+        uri = ud.url.split(";")[0]
+        gh_asset_uri = None
+
+        if (ud.user and ud.pswd) or ud.github_private:
+            fetchcmd += " --auth-no-challenge"
+            if ud.user and ud.pswd:
+                fetchcmd += " --user=%s --password=%s" % (ud.user, ud.pswd)
+
+        if ud.github_private:
+            # Github private repositories support basic-auth via the API
+            # endpoints only. Using those, the download URL will be
+            # different, and we need to download using application/octet-stream.
+            # The API endpoint mapping is different for github.com and
+            # GitHub Enterprise:
+            #     github.com -> api.github.com
+            #     github.example.com -> github.example.com/api/v3/
+            # The Accept header is used in any case to fix the API version
+            #
+            # To get the download URL when using the API, all the releases
+            # are listed via
+            #     https://api.github.com/<user>/<project>/releases
+            # which returns a JSON message describing all releases and all
+            # their attached artefacts. We can easily search that for
+            # the artefact that we're trying to download, and use
+            # the replacement URL from that response.
+            gh_relcmd = fetchcmd + " --header='Accept: application/vnd.github.v3+json'"
+            api_replacements = ['https?$://github.com/.* TYPE://api.github.com/repos/REPORELEASES',
+                                'https?$://.*/.* TYPE://HOST/api/v3/repos/REPORELEASES']
+            replacements = {}
+            replacements["TYPE"] = ud.type
+            replacements["HOST"] = ud.host
+            # github release artifacts are of the form
+            #     https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt
+            # drop everything after .../releases and point to api.github.com
+            replacements["REPORELEASES"] = ud.path.rsplit('/', maxsplit=3)[0]
+            for api_replacement in api_replacements:
+                (find, replace) = api_replacement.split()
+                rel_api_uri = uri_replace(ud, find, replace, replacements, d)
+                if rel_api_uri == None:
+                    continue
+                # uri_replace() keeps the params, and the actual filename.
+                # drop both - we only want
+                #     https://api.github.com/<user>/<project>/releases
+                # from the example above
+                rel_api_uri = rel_api_uri.split(';')[0].rsplit('/', maxsplit=1)[0]
+                with tempfile.TemporaryDirectory(prefix="wget-github-release-") as workdir, \
+                        tempfile.NamedTemporaryFile(mode="w+", dir=workdir, prefix="wget-release-") as f:
+                    gh_relcmd += " -O " + f.name + " '" + rel_api_uri + "'"
+                    try:
+                        self._runwget(ud, d, gh_relcmd, True)
+                    except FetchError as e:
+                        # Accessing a (PRE)MIRROR using the github API
+                        # obviously doesn't work, just ignore
+                        continue
+                    if os.path.getsize(f.name) == 0:
+                        # the fetch resulted in a zero size file, ignore
+                        continue
+                    releases = json.load(f)
+                    # As per https://developer.github.com/v3/repos/releases/#list-releases-for-a-repository
+                    # Each release will have a list of assets, where the 'browser_download_url'
+                    # is what we intended to download, but we need to get it via the 'url',
+                    # which points to the github api and supports username/password
+                    for release in releases:
+                        for asset in release['assets']:
+                            if asset['browser_download_url'] == uri:
+                                gh_asset_uri = asset['url']
+                                break
+                        if gh_asset_uri:
+                            break
+                if gh_asset_uri:
+                    uri = gh_asset_uri
+                    fetchcmd += " --header='Accept: application/octet-stream'"
+                    break
+
+        if 'downloadfilename' in ud.parm or gh_asset_uri:
             dldir = d.getVar("DL_DIR")
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
             fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
-        if ud.user and ud.pswd:
-            fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
-
-        uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
-- 
2.23.0.rc1


