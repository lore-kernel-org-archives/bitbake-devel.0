Return-Path: <andre.draszik@gmail.com>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail.openembedded.org (Postfix) with ESMTP id 7313B7F961
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2019 10:08:33 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id q10so8821454wrm.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2019 02:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FAKp+/Z36B7Tb68YsMTB4sHDDIzrHUH7FWCqw9elE/k=;
	b=JtVS1OZFggQSALbXEaR2CX3USJHUe/dmI/qNze5X1ohnbLvs2eSSlPxzCrTgVgYohI
	R+J9dfUATxQMk1Et6gFkRI4H1VEJ73f7ggcRnahGP04bVq9PEOcutF/MEiQce6OijMSD
	Mh5NZIF+TSdHprJkx0NP2f8bd1KVTY9UBGCZxPrysB+Zq6y2ZSPD8fcsm/3BsmY0opRg
	0Chl/cZSDVmFpZtTSMniwIRCDtAfVLRcSwzMA9u4SFtrCaj9piZbPl474ov20GHNEvke
	MLvYLsAw5klRxRsJDDUZJ7YJBtviurQjkAzLycounRKGWVYuhil/xv21qqhOoKtYcv6f
	jQfQ==
X-Gm-Message-State: APjAAAWJ3PVYdV8Q1ZUr2grPVZf1iCOuZg/OJYMDHFc/VmWr/O8Sz01a
	rxkZ6p/8HLkgMeXwDgcquxcNx0P5LGg=
X-Google-Smtp-Source: APXvYqywYW8qklYxyjis27HB8iH8+yZ8jYjKZw9uQCLOwb3VWaW4rWraTGC0CSDvekeOHfEDcuW2eA==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr15029459wrv.0.1576836513429;
	Fri, 20 Dec 2019 02:08:33 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	i10sm9300567wru.16.2019.12.20.02.08.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Dec 2019 02:08:32 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Dec 2019 10:08:31 +0000
Message-Id: <20191220100831.33196-1-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191114142131.29829-1-git@andred.net>
References: <20191114142131.29829-1-git@andred.net>
MIME-Version: 1.0
Subject: [master][PATCH v2] fetch2/githubprivate: new fetcher for private github repositories
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
X-List-Received-Date: Fri, 20 Dec 2019 10:08:33 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The wget / http fetcher doesn't support fetching assets
attached to releases on private GitHub repositories, i.e.
release artefacts like
    https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt

Those are special, in that HTTP basic auth is not used / possible
on the URL as seen in the GitHub UI, but instead the GitHub API
must be used for downloading (which does support HTTP basic auth)
where the URL will be different.

Implement a new fetcher that:
    * uses the GitHub API to determine the asset URL
    * re-uses the existing wget fetcher to download this URL
      instead
    * supports checkstatus() (bitbake -c checkuri)
    * supports latest_versionstring() (devtool latest-version)
    * supports GitHub.com and GitHub Enterprise for the above

Implementation notes:
To be able to access the GitHub API, opportunistic authentication
(auth-no-challenge) needs to be enabled. Then the API needs to
be queried for the real URL of the file to be downloaded, and
finally application/octet-stream must be specified explicitly.

Note that there is a slight difference in the location of the
REST API endpoints between GitHub.com and GitHub Enterprise.

    https://developer.github.com/v3/repos/releases/
    https://developer.github.com/enterprise/2.19/v3/enterprise-admin/

Some notes:
* --auth-no-challenge is added unconditionally because we know
  username / password will definitely be needed, and they are
  likely specified in ~/.netrc, rather than in the recipe (but
  username / password via recipe is still supported)
* the release information returned looks sth like:
[
    {
        ...
        "name": <name of the release>
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
* to determine the latest available version, we can simply query
  the API for the version (name) that the SRC_URI entry is
  attached to, and then figure out if there is a more recent
  version available, rather than doing lots of matches using
  regexes
* this has been tested with github.com and GitHub Enterprise on
  private repositories, with and without PREMIRRORS

Signed-off-by: André Draszik <git@andred.net>
---
 bitbake/lib/bb/fetch2/__init__.py      |   6 +-
 bitbake/lib/bb/fetch2/githubprivate.py | 174 +++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 2 deletions(-)
 create mode 100644 bitbake/lib/bb/fetch2/githubprivate.py

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 07de6c2693..5c533cf78e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1238,13 +1238,13 @@ class FetchData(object):
             self.sha256_name = "sha256sum"
         if self.md5_name in self.parm:
             self.md5_expected = self.parm[self.md5_name]
-        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3"]:
+        elif self.type not in ["http", "https", "ftp", "ftps", "githubprivate", "sftp", "s3"]:
             self.md5_expected = None
         else:
             self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
-        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3"]:
+        elif self.type not in ["http", "https", "ftp", "ftps", "githubprivate", "sftp", "s3"]:
             self.sha256_expected = None
         else:
             self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
@@ -1853,6 +1853,7 @@ from . import osc
 from . import repo
 from . import clearcase
 from . import npm
+from . import githubprivate
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1871,3 +1872,4 @@ methods.append(osc.Osc())
 methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
+methods.append(githubprivate.Githubprivate())
diff --git a/bitbake/lib/bb/fetch2/githubprivate.py b/bitbake/lib/bb/fetch2/githubprivate.py
new file mode 100644
index 0000000000..5a007c4e69
--- /dev/null
+++ b/bitbake/lib/bb/fetch2/githubprivate.py
@@ -0,0 +1,174 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+"""
+Bitbake "Fetch" implementation for assets attached to private
+repositories on GitHub or GitHub Enterprise.
+"""
+
+import os
+import json
+import tempfile
+import bb
+from   bb.fetch2.wget import Wget
+from   bb.fetch2 import FetchError
+from   bb.fetch2 import logger
+from   bb.fetch2 import uri_replace
+
+class Githubprivate(Wget):
+    """Class to fetch an asset from a private repository on GitHub
+       (or GitHub Enterprise)."""
+
+    def supports(self, ud, d):
+        return ud.type in ['githubprivate']
+
+    def urldata_init(self, ud, d):
+        ud.proto = 'https'
+        if 'protocol' in ud.parm:
+            ud.proto = ud.parm['protocol']
+        if not ud.proto in ('http', 'https'):
+            raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
+
+        if not 'downloadfilename' in ud.parm:
+            # The asset filename determined using the GitHub API will
+            # not match the filename of the release artefact (as in
+            # SRC_URI). Hence we need to unconditionally instruct
+            # wget to download using -O. This can be achieved by
+            # unconditionally setting 'downloadfilename' here.
+            ud.parm['downloadfilename'] = os.path.basename(ud.path)
+        super(Githubprivate, self).urldata_init(ud, d)
+        # To be able to access the GitHub API, opportunistic authentication
+        # needs to be enabled. Also username / password will definitely be
+        # needed, and they are likely specified in ~/.netrc, rather than in
+        # the recipe itself.
+        self.basecmd += " --auth-no-challenge"
+
+    def _get_gh_releases_info(self, uri, ud, d):
+        fetchcmd = self.basecmd
+        if ud.user and ud.pswd:
+            fetchcmd += " --user=%s --password=%s" % (ud.user, ud.pswd)
+
+        # Github private repositories support basic-auth via the API
+        # endpoints only. Using those, the download URL will be
+        # different, and we need to download using application/octet-stream.
+        # The API endpoint mapping is different for github.com and
+        # GitHub Enterprise:
+        #     github.com -> api.github.com
+        #     github.example.com -> github.example.com/api/v3/
+        # The Accept header is used in any case to fix the API version to
+        # the supported level (version 3).
+        #
+        # To get the download URL when using the API, all the releases
+        # are listed via
+        #     https://api.github.com/<user>/<project>/releases
+        # which returns a JSON message describing all releases and all
+        # their attached artefacts. We can easily search that for
+        # the artefact that we're trying to download, and use
+        # the replacement URL from that response.
+        assetinfo_cmd = fetchcmd + " --header='Accept: application/vnd.github.v3+json'"
+        api_replacements = ['githubprivate://github.com/.* TYPE://api.github.com/repos/REPORELEASES',
+                            'githubprivate://.*/.* TYPE://HOST/api/v3/repos/REPORELEASES']
+        replacements = {}
+        replacements["TYPE"] = ud.proto
+        replacements["HOST"] = ud.host
+        # github release artifacts are of the form
+        #     https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt
+        # drop everything after .../releases and point to api.github.com
+        replacements["REPORELEASES"] = ud.path.rsplit('/', maxsplit=3)[0]
+        for api_replacement in api_replacements:
+            (find, replace) = api_replacement.split()
+            rel_api_uri = uri_replace(ud, find, replace, replacements, d)
+            if rel_api_uri == None:
+                continue
+            # uri_replace() keeps the params, and the actual filename.
+            # drop both - we only want
+            #     https://api.github.com/<user>/<project>/releases
+            # from the example above
+            rel_api_uri = rel_api_uri.split(';')[0].rsplit('/', maxsplit=1)[0]
+            with tempfile.TemporaryDirectory(prefix="wget-github-release-") as workdir, \
+                    tempfile.NamedTemporaryFile(mode="w+", dir=workdir, prefix="wget-release-") as f:
+                assetinfo_cmd += " -O " + f.name + " '" + rel_api_uri + "'"
+                logger.debug(2, "For url %s trying to retrieve asset info from %s" % (uri, assetinfo_cmd))
+                try:
+                    self._runwget(ud, d, assetinfo_cmd, True)
+                except FetchError as e:
+                    # Accessing a (PRE)MIRROR using the github API
+                    # obviously doesn't work, just ignore
+                    continue
+                if os.path.getsize(f.name) == 0:
+                    # the fetch resulted in a zero size file, ignore
+                    logger.debug(2, "Could not retrieve asset info from %s" % rel_api_uri)
+                    continue
+                return json.load(f)
+
+        return []
+
+    def _get_gh_asset_uri(self, uri, ud, d):
+        uri = uri.replace("githubprivate://", ud.proto + "://", 1)
+        gh_asset_uri = None
+        releases = self._get_gh_releases_info(uri, ud, d)
+        # As per https://developer.github.com/v3/repos/releases/#list-releases-for-a-repository
+        # Each release will have a list of assets, where the 'browser_download_url'
+        # is what we intended to download, but we need to get it via the 'url',
+        # which points to the github api and supports username/password
+        for release in releases:
+            for asset in release['assets']:
+                logger.debug(2, "Comparing asset id %u URL %s" \
+                                % (asset['id'], asset['browser_download_url']))
+                if asset['browser_download_url'] == uri:
+                    gh_asset_uri = asset['url']
+                    logger.debug(2, "For URI %s using GitHub asset %s" % (uri, gh_asset_uri))
+                    break
+            if gh_asset_uri:
+                break
+
+        if not gh_asset_uri:
+            raise FetchError("Could not determine the GitHub asset URI for URI %s" % uri, uri)
+
+        return gh_asset_uri
+
+    def download(self, ud, d):
+        """Fetch urls"""
+        orig_uri = ud.url.split(";")[0]
+        gh_asset_uri = self._get_gh_asset_uri(orig_uri, ud, d)
+        ud.url = ud.url.replace(orig_uri, gh_asset_uri, 1)
+        # To be able to download the actual asset, we need to force
+        # the mime-type. Otherwise we'll get the asset info json.
+        self.basecmd += " --header='Accept: application/octet-stream'"
+        return super(Githubprivate, self).download(ud, d)
+
+    def latest_versionstring(self, ud, d):
+        """
+        Manipulate the URL and try to obtain the latest package version
+        using GitHub API.
+        """
+        # We first get the release (name) that corresponds to the URL ...
+        uri = ud.url.split(";")[0].replace("githubprivate://", ud.proto + "://", 1)
+        releases = self._get_gh_releases_info(uri, ud, d)
+        current_version = '0'
+        for release in releases:
+            bb.debug(3, "Getting current version info for URL %s" % uri)
+            for release in releases:
+                for asset in release['assets']:
+                    if asset['browser_download_url'] == uri:
+                        current_version = release['name']
+                        break
+                if current_version != '0':
+                    break
+            if current_version != '0':
+                bb.debug(3, "Current version info is %s" % current_version)
+
+        # ... and then try to find a newer release (name).
+        for release in releases:
+            this_version = ['', release['name'], '']
+            if self._vercmp(['', current_version, ''], this_version) < 0:
+                current_version = this_version[1]
+
+        return (current_version, '')
+
+    def checkstatus(self, fetch, urldata, d):
+        """Check if urls are accessible"""
+        orig_uri = urldata.url.split(";")[0]
+        gh_asset_uri = self._get_gh_asset_uri(orig_uri, urldata, d)
+        urldata.url = urldata.url.replace(orig_uri, gh_asset_uri, 1)
+        return super(Githubprivate, self).checkstatus(fetch, urldata, d)
-- 
2.23.0.rc1


