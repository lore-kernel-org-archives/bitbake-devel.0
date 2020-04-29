Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.3816.1588174813074201878
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2020 08:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yi5syWfh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id x4so2561843wmj.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2020 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3f9LqwweDPZ/zXr8O/zYbvFOPwcm2L0qamVjPEha3E=;
        b=Yi5syWfhsPY5cnaH5PPhrmYZ1Wj1S1JPSGLMJjBhT3J5lHJAQx2q9zeiTG8mS+IPP4
         2jPb+3ipeqk8eiyAwaaGNJLyJn+ahDrrbdQN0x5I3E2xXIrK4p53F1eqNtCW4up5oNSa
         MueSYVoLt1xjyTUQ4lZKAM6aCs0OblN3899NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3f9LqwweDPZ/zXr8O/zYbvFOPwcm2L0qamVjPEha3E=;
        b=aH6CA2WDM8v9uVih3GpFQakESwgT/bVPVG2Iq8PCIFUEkfTVyatyjdmfx94vIi1Y6L
         OCMct3T+VVUw2mPSPFl3xp82SVEldKHPwW1sJbf/un7LtIFPj5SKG+UiD2q24UERZiNE
         bXoIUDbyRdtvZEfpo1npt/YR9nzQRCe4GYE9cVEH2zbOHuHZP1J09BLFgNzX4ijS7DoX
         5MQD+eX3aQmn4qkjniDAo3XkLAAM+2RUgmblE//5NRzBCcq/aAtYsZNBT23Sa+qsuuL8
         QKNMTjUPEFYCxXhuSr1wB/v/d0cGqG18/riJi03eQbmP8WIhX3dBh+vEG0VF1Cpe5hFf
         0Rzw==
X-Gm-Message-State: AGi0PuZ4aYwwnwXY+3hPWh1JCTGnOAlBpefK9MBjFIjWcCT+U+AqJhaW
	MOhJcwTy4ABJ3e45V0jXdc061vikPbA=
X-Google-Smtp-Source: APiQypKvzlKvlYzjv3NFRBlUPeTafrBOO8Ybs3GYxepYRfqfYAuoiQKOi4ToLoUsbu3hTCjgzHzXOw==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr3925843wmj.130.1588174810499;
        Wed, 29 Apr 2020 08:40:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id u30sm30906264wru.13.2020.04.29.08.40.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:40:09 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitdoc: Remove it
Date: Wed, 29 Apr 2020 16:40:08 +0100
Message-Id: <20200429154008.1285749-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This script took a documentation.conf and generated an HTML index of
each of the variables. The data in the yocto-docs manuals is now far
superior to this. The script has bitrotted and doesn't run, hasn't for
some time and wasn't reported until recently.

Easiest is just to remove it as anyone would reimplement it quite
differently now.

The referenced bug does have a patch which cleans up the code but I
don't see value in keeping this around.

[YOCTO #13881]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitdoc | 519 -----------------------------------------------------
 1 file changed, 519 deletions(-)
 delete mode 100755 bin/bitdoc

diff --git a/bin/bitdoc b/bin/bitdoc
deleted file mode 100755
index 9bd02be69c..0000000000
--- a/bin/bitdoc
+++ /dev/null
@@ -1,519 +0,0 @@
-#!/usr/bin/env python3
-#
-# Copyright (C) 2005 Holger Hans Peter Freyther
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-import optparse, os, sys
-
-# bitbake
-sys.path.append(os.path.join(os.path.dirname(os.path.dirname(__file__), 'lib'))
-import bb
-import bb.parse
-from   string import split, join
-
-__version__ = "0.0.2"
-
-class HTMLFormatter:
-    """
-    Simple class to help to generate some sort of HTML files. It is
-    quite inferior solution compared to docbook, gtkdoc, doxygen but it
-    should work for now.
-    We've a global introduction site (index.html) and then one site for
-    the list of keys (alphabetical sorted) and one for the list of groups,
-    one site for each key with links to the relations and groups.
-
-        index.html
-        all_keys.html
-        all_groups.html
-        groupNAME.html
-        keyNAME.html
-    """
-
-    def replace(self, text, *pairs):
-        """
-        From pydoc... almost identical at least
-        """
-        while pairs:
-            (a, b) = pairs[0]
-            text = join(split(text, a), b)
-            pairs = pairs[1:]
-        return text
-    def escape(self, text):
-        """
-        Escape string to be conform HTML
-        """
-        return self.replace(text, 
-                            ('&', '&amp;'), 
-                            ('<', '&lt;' ),
-                            ('>', '&gt;' ) )
-    def createNavigator(self):
-        """
-        Create the navgiator
-        """
-        return """<table class="navigation" width="100%" summary="Navigation header" cellpadding="2" cellspacing="2">
-<tr valign="middle">
-<td><a accesskey="g" href="index.html">Home</a></td>
-<td><a accesskey="n" href="all_groups.html">Groups</a></td>
-<td><a accesskey="u" href="all_keys.html">Keys</a></td>
-</tr></table>
-"""
-
-    def relatedKeys(self, item):
-        """
-        Create HTML to link to foreign keys
-        """
-
-        if len(item.related()) == 0:
-            return ""
-
-        txt = "<p><b>See also:</b><br>"
-        txts = []
-        for it in item.related():
-            txts.append("""<a href="key%(it)s.html">%(it)s</a>""" % vars() )
-
-        return txt + ",".join(txts)
-
-    def groups(self, item):
-        """
-        Create HTML to link to related groups
-        """
-
-        if len(item.groups()) == 0:
-            return ""
-
-
-        txt = "<p><b>See also:</b><br>"
-        txts = []
-        for group in item.groups():
-            txts.append( """<a href="group%s.html">%s</a> """ % (group, group) )
-
-        return txt + ",".join(txts)
-
-
-    def createKeySite(self, item):
-        """
-        Create a site for a key. It contains the header/navigator, a heading,
-        the description, links to related keys and to the groups.
-        """
-
-        return """<!doctype html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
-<html><head><title>Key %s</title></head>
-<link rel="stylesheet" href="style.css" type="text/css">
-<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">
-%s
-<h2><span class="refentrytitle">%s</span></h2>
-
-<div class="refsynopsisdiv">
-<h2>Synopsis</h2>
-<p>
-%s
-</p>
-</div>
-
-<div class="refsynopsisdiv">
-<h2>Related Keys</h2>
-<p>
-%s
-</p>
-</div>
-
-<div class="refsynopsisdiv">
-<h2>Groups</h2>
-<p>
-%s
-</p>
-</div>
-
-
-</body>
-"""     % (item.name(), self.createNavigator(), item.name(), 
-           self.escape(item.description()), self.relatedKeys(item), self.groups(item))
-
-    def createGroupsSite(self, doc):
-        """
-        Create the Group Overview site
-        """
-
-        groups = ""
-        sorted_groups = sorted(doc.groups())
-        for group in sorted_groups:
-            groups += """<a href="group%s.html">%s</a><br>""" % (group, group)
-
-        return """<!doctype html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
-<html><head><title>Group overview</title></head>
-<link rel="stylesheet" href="style.css" type="text/css">
-<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">
-%s
-<h2>Available Groups</h2>
-%s
-</body>
-""" % (self.createNavigator(), groups)
-
-    def createIndex(self):
-        """
-        Create the index file
-        """
-
-        return """<!doctype html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
-<html><head><title>Bitbake Documentation</title></head>
-<link rel="stylesheet" href="style.css" type="text/css">
-<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">
-%s
-<h2>Documentation Entrance</h2>
-<a href="all_groups.html">All available groups</a><br>
-<a href="all_keys.html">All available keys</a><br>
-</body>
-""" % self.createNavigator()
-
-    def createKeysSite(self, doc):
-        """
-        Create Overview of all avilable keys
-        """
-        keys = ""
-        sorted_keys = sorted(doc.doc_keys())
-        for key in sorted_keys:
-            keys += """<a href="key%s.html">%s</a><br>""" % (key, key)
-
-        return """<!doctype html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
-<html><head><title>Key overview</title></head>
-<link rel="stylesheet" href="style.css" type="text/css">
-<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">
-%s
-<h2>Available Keys</h2>
-%s
-</body>
-""" % (self.createNavigator(), keys)
-
-    def createGroupSite(self, gr, items, _description = None):
-        """
-        Create a site for a group:
-        Group the name of the group, items contain the name of the keys
-        inside this group
-        """
-        groups = ""
-        description = ""
-
-        # create a section with the group descriptions
-        if _description:
-            description  += "<h2 Description of Grozp %s</h2>" % gr
-            description  += _description
-
-        items.sort(lambda x, y:cmp(x.name(), y.name()))
-        for group in items:
-            groups += """<a href="key%s.html">%s</a><br>""" % (group.name(), group.name())
-
-        return """<!doctype html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
-<html><head><title>Group %s</title></head>
-<link rel="stylesheet" href="style.css" type="text/css">
-<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">
-%s
-%s
-<div class="refsynopsisdiv">
-<h2>Keys in Group %s</h2>
-<pre class="synopsis">
-%s
-</pre>
-</div>
-</body>
-""" % (gr, self.createNavigator(), description, gr, groups)
-
-
-
-    def createCSS(self):
-        """
-        Create the CSS file
-        """
-        return """.synopsis, .classsynopsis
-{
-  background: #eeeeee;
-  border: solid 1px #aaaaaa;
-  padding: 0.5em;
-}
-.programlisting
-{
-  background: #eeeeff;
-  border: solid 1px #aaaaff;
-  padding: 0.5em;
-}
-.variablelist
-{
-  padding: 4px;
-  margin-left: 3em;
-}
-.variablelist td:first-child
-{
-  vertical-align: top;
-}
-table.navigation
-{
-  background: #ffeeee;
-  border: solid 1px #ffaaaa;
-  margin-top: 0.5em;
-  margin-bottom: 0.5em;
-}
-.navigation a
-{
-  color: #770000;
-}
-.navigation a:visited
-{
-  color: #550000;
-}
-.navigation .title
-{
-  font-size: 200%;
-}
-div.refnamediv
-{
-  margin-top: 2em;
-}
-div.gallery-float
-{
-  float: left;
-  padding: 10px;
-}
-div.gallery-float img
-{
-  border-style: none;
-}
-div.gallery-spacer
-{
-  clear: both;
-}
-a
-{
-  text-decoration: none;
-}
-a:hover
-{
-  text-decoration: underline;
-  color: #FF0000;
-}
-"""
-
-
-
-class DocumentationItem:
-    """
-    A class to hold information about a configuration
-    item. It contains the key name, description, a list of related names,
-    and the group this item is contained in.
-    """
-
-    def __init__(self):
-        self._groups  = []
-        self._related = []
-        self._name    = ""
-        self._desc    = ""
-
-    def groups(self):
-        return self._groups
-
-    def name(self):
-        return self._name
-
-    def description(self):
-        return self._desc
-
-    def related(self):
-        return self._related
-
-    def setName(self, name):
-        self._name = name
-
-    def setDescription(self, desc):
-        self._desc = desc
-
-    def addGroup(self, group):
-        self._groups.append(group)
-
-    def addRelation(self, relation):
-        self._related.append(relation)
-
-    def sort(self):
-        self._related.sort()
-        self._groups.sort()
-
-
-class Documentation:
-    """
-    Holds the documentation... with mappings from key to items...
-    """
-
-    def __init__(self):
-        self.__keys   = {}
-        self.__groups = {}
-
-    def insert_doc_item(self, item):
-        """
-        Insert the Doc Item into the internal list
-        of representation
-        """
-        item.sort()
-        self.__keys[item.name()] = item
-
-        for group in item.groups():
-            if not group in self.__groups:
-                self.__groups[group] = []
-            self.__groups[group].append(item)
-            self.__groups[group].sort()
-
-
-    def doc_item(self, key):
-        """
-        Return the DocumentationInstance describing the key
-        """
-        try:
-            return self.__keys[key]
-        except KeyError:
-            return None
-
-    def doc_keys(self):
-        """
-        Return the documented KEYS (names)
-        """
-        return self.__keys.keys()
-
-    def groups(self):
-        """
-        Return the names of available groups
-        """
-        return self.__groups.keys()
-
-    def group_content(self, group_name):
-        """
-        Return a list of keys/names that are in a specefic
-        group or the empty list
-        """
-        try:
-            return self.__groups[group_name]
-        except KeyError:
-            return []
-
-
-def parse_cmdline(args):
-    """
-    Parse the CMD line and return the result as a n-tuple
-    """
-
-    parser = optparse.OptionParser( version = "Bitbake Documentation Tool Core version %s, %%prog version %s" % (bb.__version__, __version__))
-    usage  = """%prog [options]
-
-Create a set of html pages (documentation) for a bitbake.conf....
-"""
-
-    # Add the needed options
-    parser.add_option( "-c", "--config", help = "Use the specified configuration file as source",
-                       action = "store", dest = "config", default = os.path.join("conf", "documentation.conf") )
-
-    parser.add_option( "-o", "--output", help = "Output directory for html files",
-                       action = "store", dest = "output", default = "html/" )
-
-    parser.add_option( "-D",  "--debug", help = "Increase the debug level",
-                       action = "count", dest = "debug", default = 0 )
-
-    parser.add_option( "-v", "--verbose", help = "output more chit-char to the terminal",
-                       action = "store_true", dest = "verbose", default = False )
-
-    options, args = parser.parse_args( sys.argv )
- 
-    bb.msg.init_msgconfig(options.verbose, options.debug)
-
-    return options.config, options.output
-
-def main():
-    """
-    The main Method
-    """
-
-    (config_file, output_dir) = parse_cmdline( sys.argv )
-
-    # right to let us load the file now
-    try:
-        documentation = bb.parse.handle( config_file, bb.data.init() )
-    except IOError:
-        bb.fatal( "Unable to open %s" % config_file )
-    except bb.parse.ParseError:
-        bb.fatal( "Unable to parse %s" % config_file )
-
-    if isinstance(documentation, dict):
-        documentation = documentation[""]
-
-    # Assuming we've the file loaded now, we will initialize the 'tree'
-    doc = Documentation()
-
-    # defined states
-    state_begin = 0
-    state_see   = 1
-    state_group = 2
-
-    for key in bb.data.keys(documentation):
-        data   = documentation.getVarFlag(key, "doc", False)
-        if not data:
-            continue
-
-        # The Documentation now starts
-        doc_ins = DocumentationItem()
-        doc_ins.setName(key)
-
-
-        tokens = data.split(' ')
-        state = state_begin
-        string= ""
-        for token in tokens:
-            token = token.strip(',')
-
-            if not state == state_see and token == "@see":
-                state = state_see
-                continue
-            elif not state == state_group and token  == "@group":
-                state = state_group
-                continue
-
-            if state == state_begin:
-                string += " %s" % token
-            elif state == state_see:
-                doc_ins.addRelation(token)
-            elif state == state_group:
-                doc_ins.addGroup(token)
-
-        # set the description
-        doc_ins.setDescription(string)
-        doc.insert_doc_item(doc_ins)
-
-    # let us create the HTML now
-    bb.utils.mkdirhier(output_dir)
-    os.chdir(output_dir)
-
-    # Let us create the sites now. We do it in the following order
-    # Start with the index.html. It will point to sites explaining all
-    # keys and groups
-    html_slave = HTMLFormatter()
-
-    f = file('style.css', 'w')
-    print >> f, html_slave.createCSS()
-
-    f = file('index.html', 'w')
-    print >> f, html_slave.createIndex()
-
-    f = file('all_groups.html', 'w')
-    print >> f, html_slave.createGroupsSite(doc)
-
-    f = file('all_keys.html', 'w')
-    print >> f, html_slave.createKeysSite(doc)
-
-    # now for each group create the site
-    for group in doc.groups():
-        f = file('group%s.html' % group, 'w')
-        print >> f, html_slave.createGroupSite(group, doc.group_content(group))
-
-    # now for the keys
-    for key in doc.doc_keys():
-        f = file('key%s.html' % doc.doc_item(key).name(), 'w')
-        print >> f, html_slave.createKeySite(doc.doc_item(key))
-
-
-if __name__ == "__main__":
-    main()
-- 
2.25.1

