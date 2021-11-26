Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F9C433F5
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 05:18:13 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.20665.1637903892724656745
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 21:18:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XbZ/QH6U;
 spf=pass (domain: gmail.com, ip: 209.85.210.172,
 mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id n26so7819274pff.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuzoKLKVcnSsfmAEAPSZ7SOMNYDl4/ui2FI6aFRNBUc=;
        b=XbZ/QH6UZxh6vIR7g1LBBGsPO4ZOnGEvZorf4wobkEsMmS3y2aUmbo6KDAMgSEyfuo
         eBE6fuc5vm6BFi+ZnCs0XozGLatRnxMyTXyLenpyZREGebuSu4OZor24lVolb3/Cq18R
         fFjQv2Y8okV8ZTXkWdbd9rybhw1Va0+BUungWxJkYAwPWSFRCLuUi+CzyG599V3IUmxA
         YZRvaHoTuYr+LN2Zl8HQL0ifkepb59M0seMIQiRalCMEzW7XvqzJNlZdpIpVt39VtNWV
         0E2M73dQsjo0fu7eGG0TQDqDAkXpcJoBdE2kcRzGUan2VBFGXY3ThGwGg1XYBhapF9es
         POEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuzoKLKVcnSsfmAEAPSZ7SOMNYDl4/ui2FI6aFRNBUc=;
        b=B2uFxNKUtrO7UYWVow5Xlc7m/lXQJrLuXVzl0if63NWRfLpHor5AVc2zp4yAH/z2ar
         7BT9Wq0wrJzhZNr98r5VUNg2IYtUpSkilibZejknxOonDyB9wERMLRzQPX2myMj+2OBX
         xT4bLGk3iw2F1BW6ne/RZGF7bzMJlCp12cnxy8trsGbqEZOCW11NvcxtSrKPTW52XerA
         YwnTyxK/HywGtXvkPqnyNNoEjIIXYgmCvkck0v8lKwQ2LqHZais6hVVsNtI3Z2yND/V6
         HuJrUQJglG8HCFG0VAawkx1EzP55JQ3QcZpJ+FzSA44mg5cIUZ2e1i4uV3ZZt/rfKq+0
         WDzQ==
X-Gm-Message-State: AOAM531q31/F5HJDtk5dVJybFCc442KJpE+9Y3Hq3WITOGOTgOf3k8/U
	c2OGL7cRcCnl2DKjDu2MGwO/jjqcqHc=
X-Google-Smtp-Source: 
 ABdhPJzhJs69Xle7BqcFmPkxlu59T9Dij/519Xk8n0hqXzn9Ln+ezNKGhkr7/FbFL44EgZ7OqsDK4g==
X-Received: by 2002:a63:6702:: with SMTP id b2mr19949820pgc.185.1637903891695;
        Thu, 25 Nov 2021 21:18:11 -0800 (PST)
Received: from nereus.local ([2601:1c0:6000:1830:2111:e66e:a58a:6736])
        by smtp.gmail.com with ESMTPSA id
 u3sm5373064pfk.32.2021.11.25.21.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 21:18:11 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <timothy.t.orling@intel.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <timothy.t.orling@intel.com>
Subject: [PATCH] lib/bb/version.py: add from distutils.version
Date: Thu, 25 Nov 2021 21:18:00 -0800
Message-Id: <20211126051800.2364615-1-timothy.t.orling@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Nov 2021 05:18:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13111

In places like sanity.bbclass we currently use
distutils.version.LooseVersion, but distutils is deprecated in Python
3.10 and will be removed in Python 3.12 (~October 2023).

The recommended replacement for for distutils.version.LooseVersion is
packaging.version.Version, but this implies 'packaging' be installed on
the host. It is also not the same functionality as LooseVersion.

[YOCTO #14610]

Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
---
 lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 347 insertions(+)
 create mode 100644 lib/bb/version.py

diff --git a/lib/bb/version.py b/lib/bb/version.py
new file mode 100644
index 00000000..510582b5
--- /dev/null
+++ b/lib/bb/version.py
@@ -0,0 +1,347 @@
+#
+# distutils/version.py
+#
+# Implements multiple version numbering conventions for the
+# Python Module Distribution Utilities.
+#
+# SPDX-License-Identifier: PSF-2.0
+#
+
+"""Provides classes to represent module version numbers (one class for
+each style of version numbering).  There are currently two such classes
+implemented: StrictVersion and LooseVersion.
+
+Every version number class implements the following interface:
+  * the 'parse' method takes a string and parses it to some internal
+    representation; if the string is an invalid version number,
+    'parse' raises a ValueError exception
+  * the class constructor takes an optional string argument which,
+    if supplied, is passed to 'parse'
+  * __str__ reconstructs the string that was passed to 'parse' (or
+    an equivalent string -- ie. one that will generate an equivalent
+    version number instance)
+  * __repr__ generates Python code to recreate the version number instance
+  * _cmp compares the current instance with either another instance
+    of the same class or a string (which will be parsed to an instance
+    of the same class, thus must follow the same rules)
+"""
+
+import re
+
+class Version:
+    """Abstract base class for version numbering classes.  Just provides
+    constructor (__init__) and reproducer (__repr__), because those
+    seem to be the same for all version numbering classes; and route
+    rich comparisons to _cmp.
+    """
+
+    def __init__ (self, vstring=None):
+        if vstring:
+            self.parse(vstring)
+
+    def __repr__ (self):
+        return "%s ('%s')" % (self.__class__.__name__, str(self))
+
+    def __eq__(self, other):
+        c = self._cmp(other)
+        if c is NotImplemented:
+            return c
+        return c == 0
+
+    def __lt__(self, other):
+        c = self._cmp(other)
+        if c is NotImplemented:
+            return c
+        return c < 0
+
+    def __le__(self, other):
+        c = self._cmp(other)
+        if c is NotImplemented:
+            return c
+        return c <= 0
+
+    def __gt__(self, other):
+        c = self._cmp(other)
+        if c is NotImplemented:
+            return c
+        return c > 0
+
+    def __ge__(self, other):
+        c = self._cmp(other)
+        if c is NotImplemented:
+            return c
+        return c >= 0
+
+
+# Interface for version-number classes -- must be implemented
+# by the following classes (the concrete ones -- Version should
+# be treated as an abstract class).
+#    __init__ (string) - create and take same action as 'parse'
+#                        (string parameter is optional)
+#    parse (string)    - convert a string representation to whatever
+#                        internal representation is appropriate for
+#                        this style of version numbering
+#    __str__ (self)    - convert back to a string; should be very similar
+#                        (if not identical to) the string supplied to parse
+#    __repr__ (self)   - generate Python code to recreate
+#                        the instance
+#    _cmp (self, other) - compare two version numbers ('other' may
+#                        be an unparsed version string, or another
+#                        instance of your version class)
+
+
+class StrictVersion (Version):
+
+    """Version numbering for anal retentives and software idealists.
+    Implements the standard interface for version number classes as
+    described above.  A version number consists of two or three
+    dot-separated numeric components, with an optional "pre-release" tag
+    on the end.  The pre-release tag consists of the letter 'a' or 'b'
+    followed by a number.  If the numeric components of two version
+    numbers are equal, then one with a pre-release tag will always
+    be deemed earlier (lesser) than one without.
+
+    The following are valid version numbers (shown in the order that
+    would be obtained by sorting according to the supplied cmp function):
+
+        0.4       0.4.0  (these two are equivalent)
+        0.4.1
+        0.5a1
+        0.5b3
+        0.5
+        0.9.6
+        1.0
+        1.0.4a3
+        1.0.4b1
+        1.0.4
+
+    The following are examples of invalid version numbers:
+
+        1
+        2.7.2.2
+        1.3.a4
+        1.3pl1
+        1.3c4
+
+    The rationale for this version numbering system will be explained
+    in the distutils documentation.
+    """
+
+    version_re = re.compile(r'^(\d+) \. (\d+) (\. (\d+))? ([ab](\d+))?$',
+                            re.VERBOSE | re.ASCII)
+
+
+    def parse (self, vstring):
+        match = self.version_re.match(vstring)
+        if not match:
+            raise ValueError("invalid version number '%s'" % vstring)
+
+        (major, minor, patch, prerelease, prerelease_num) = \
+            match.group(1, 2, 4, 5, 6)
+
+        if patch:
+            self.version = tuple(map(int, [major, minor, patch]))
+        else:
+            self.version = tuple(map(int, [major, minor])) + (0,)
+
+        if prerelease:
+            self.prerelease = (prerelease[0], int(prerelease_num))
+        else:
+            self.prerelease = None
+
+
+    def __str__ (self):
+
+        if self.version[2] == 0:
+            vstring = '.'.join(map(str, self.version[0:2]))
+        else:
+            vstring = '.'.join(map(str, self.version))
+
+        if self.prerelease:
+            vstring = vstring + self.prerelease[0] + str(self.prerelease[1])
+
+        return vstring
+
+
+    def _cmp (self, other):
+        if isinstance(other, str):
+            other = StrictVersion(other)
+        elif not isinstance(other, StrictVersion):
+            return NotImplemented
+
+        if self.version != other.version:
+            # numeric versions don't match
+            # prerelease stuff doesn't matter
+            if self.version < other.version:
+                return -1
+            else:
+                return 1
+
+        # have to compare prerelease
+        # case 1: neither has prerelease; they're equal
+        # case 2: self has prerelease, other doesn't; other is greater
+        # case 3: self doesn't have prerelease, other does: self is greater
+        # case 4: both have prerelease: must compare them!
+
+        if (not self.prerelease and not other.prerelease):
+            return 0
+        elif (self.prerelease and not other.prerelease):
+            return -1
+        elif (not self.prerelease and other.prerelease):
+            return 1
+        elif (self.prerelease and other.prerelease):
+            if self.prerelease == other.prerelease:
+                return 0
+            elif self.prerelease < other.prerelease:
+                return -1
+            else:
+                return 1
+        else:
+            assert False, "never get here"
+
+# end class StrictVersion
+
+
+# The rules according to Greg Stein:
+# 1) a version number has 1 or more numbers separated by a period or by
+#    sequences of letters. If only periods, then these are compared
+#    left-to-right to determine an ordering.
+# 2) sequences of letters are part of the tuple for comparison and are
+#    compared lexicographically
+# 3) recognize the numeric components may have leading zeroes
+#
+# The LooseVersion class below implements these rules: a version number
+# string is split up into a tuple of integer and string components, and
+# comparison is a simple tuple comparison.  This means that version
+# numbers behave in a predictable and obvious way, but a way that might
+# not necessarily be how people *want* version numbers to behave.  There
+# wouldn't be a problem if people could stick to purely numeric version
+# numbers: just split on period and compare the numbers as tuples.
+# However, people insist on putting letters into their version numbers;
+# the most common purpose seems to be:
+#   - indicating a "pre-release" version
+#     ('alpha', 'beta', 'a', 'b', 'pre', 'p')
+#   - indicating a post-release patch ('p', 'pl', 'patch')
+# but of course this can't cover all version number schemes, and there's
+# no way to know what a programmer means without asking him.
+#
+# The problem is what to do with letters (and other non-numeric
+# characters) in a version number.  The current implementation does the
+# obvious and predictable thing: keep them as strings and compare
+# lexically within a tuple comparison.  This has the desired effect if
+# an appended letter sequence implies something "post-release":
+# eg. "0.99" < "0.99pl14" < "1.0", and "5.001" < "5.001m" < "5.002".
+#
+# However, if letters in a version number imply a pre-release version,
+# the "obvious" thing isn't correct.  Eg. you would expect that
+# "1.5.1" < "1.5.2a2" < "1.5.2", but under the tuple/lexical comparison
+# implemented here, this just isn't so.
+#
+# Two possible solutions come to mind.  The first is to tie the
+# comparison algorithm to a particular set of semantic rules, as has
+# been done in the StrictVersion class above.  This works great as long
+# as everyone can go along with bondage and discipline.  Hopefully a
+# (large) subset of Python module programmers will agree that the
+# particular flavour of bondage and discipline provided by StrictVersion
+# provides enough benefit to be worth using, and will submit their
+# version numbering scheme to its domination.  The free-thinking
+# anarchists in the lot will never give in, though, and something needs
+# to be done to accommodate them.
+#
+# Perhaps a "moderately strict" version class could be implemented that
+# lets almost anything slide (syntactically), and makes some heuristic
+# assumptions about non-digits in version number strings.  This could
+# sink into special-case-hell, though; if I was as talented and
+# idiosyncratic as Larry Wall, I'd go ahead and implement a class that
+# somehow knows that "1.2.1" < "1.2.2a2" < "1.2.2" < "1.2.2pl3", and is
+# just as happy dealing with things like "2g6" and "1.13++".  I don't
+# think I'm smart enough to do it right though.
+#
+# In any case, I've coded the test suite for this module (see
+# ../test/test_version.py) specifically to fail on things like comparing
+# "1.2a2" and "1.2".  That's not because the *code* is doing anything
+# wrong, it's because the simple, obvious design doesn't match my
+# complicated, hairy expectations for real-world version numbers.  It
+# would be a snap to fix the test suite to say, "Yep, LooseVersion does
+# the Right Thing" (ie. the code matches the conception).  But I'd rather
+# have a conception that matches common notions about version numbers.
+
+class LooseVersion (Version):
+
+    """Version numbering for anarchists and software realists.
+    Implements the standard interface for version number classes as
+    described above.  A version number consists of a series of numbers,
+    separated by either periods or strings of letters.  When comparing
+    version numbers, the numeric components will be compared
+    numerically, and the alphabetic components lexically.  The following
+    are all valid version numbers, in no particular order:
+
+        1.5.1
+        1.5.2b2
+        161
+        3.10a
+        8.02
+        3.4j
+        1996.07.12
+        3.2.pl0
+        3.1.1.6
+        2g6
+        11g
+        0.960923
+        2.2beta29
+        1.13++
+        5.5.kw
+        2.0b1pl0
+
+    In fact, there is no such thing as an invalid version number under
+    this scheme; the rules for comparison are simple and predictable,
+    but may not always give the results you want (for some definition
+    of "want").
+    """
+
+    component_re = re.compile(r'(\d+ | [a-z]+ | \.)', re.VERBOSE)
+
+    def __init__ (self, vstring=None):
+        if vstring:
+            self.parse(vstring)
+
+
+    def parse (self, vstring):
+        # I've given up on thinking I can reconstruct the version string
+        # from the parsed tuple -- so I just store the string here for
+        # use by __str__
+        self.vstring = vstring
+        components = [x for x in self.component_re.split(vstring)
+                              if x and x != '.']
+        for i, obj in enumerate(components):
+            try:
+                components[i] = int(obj)
+            except ValueError:
+                pass
+
+        self.version = components
+
+
+    def __str__ (self):
+        return self.vstring
+
+
+    def __repr__ (self):
+        return "LooseVersion ('%s')" % str(self)
+
+
+    def _cmp (self, other):
+        if isinstance(other, str):
+            other = LooseVersion(other)
+        elif not isinstance(other, LooseVersion):
+            return NotImplemented
+
+        if self.version == other.version:
+            return 0
+        if self.version < other.version:
+            return -1
+        if self.version > other.version:
+            return 1
+
+
+# end class LooseVersion
-- 
2.30.2


