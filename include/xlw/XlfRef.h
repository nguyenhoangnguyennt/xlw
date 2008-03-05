
/*
 Copyright (C) 1998, 1999, 2001, 2002, 2003, 2004 J�r�me Lecomte
 Copyright (C) 2007, 2008 Eric Ehlers

 This file is part of XLW, a free-software/open-source C++ wrapper of the
 Excel C API - http://xlw.sourceforge.net/

 XLW is free software: you can redistribute it and/or modify it under the
 terms of the XLW license.  You should have received a copy of the
 license along with this program; if not, please email xlw-users@lists.sf.net

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/


#ifndef INC_XlfRef_H
#define INC_XlfRef_H

/*!
\file XlfRef.h
\brief Class XlfRef - Encapsulate a range of cells
*/

// $Id$

#include <xlw/EXCEL32_API.h>
#include <xlw/xlcall32.h>
#include <iostream>

#if defined(_MSC_VER)
#pragma once
#endif

// Forward declaration.
//! Wrapper around XLOPER Excel data type.
class EXCEL32_API XlfOper;

//! Encapsulate a range of cells.
/*!
A range is actually a reference to a range of cells in the spreadsheet.
This range is stored as an absolute reference even if you can access
the elements relatively to the upper left corner of the range (starting
at 0 to number of row/column minus 1).

The dtor, copy ctor and assignment otor are generated by the compiler.

\note The Excel API is limited to the first 256 columns. This class holds
a reference to a single range in a single spreadsheet. It is intended to
be a helper class to refer to ranges through XlfOper.

\note It is currently not possible for XlfRef to handle union of range
in the same way other Excel functions can. This feature remains to be
implemented.
*/

class EXCEL32_API XlfRef
{
public:
    //! \name Constructors
    //@{
    //! Default ctor.
    XlfRef();
    //! Absolute reference ctor.
    XlfRef(INT32 top, INT32 left, INT32 bottom, INT32 right, DWORD sheetId = 0);
    //! Absolute reference ctor, to a single cell.
    XlfRef(INT32 row, INT32 col, DWORD sheetId = 0);
    //@}

    //! \name Get and set class properties
    //@{
    //! Gets the first row of the range (0 based).
    INT32 GetRowBegin() const;
    //! Gets passed the last row of the range (0 based).
    INT32 GetRowEnd() const;
    //! Gets the first column of the range (0 based).
    INT32 GetColBegin() const;
    //! Gets passed the last column of the range (0 based).
    INT32 GetColEnd() const;
    //! Gets the number of columns.
    INT32 GetNbCols() const;
    //! Gets the number of rows.
    INT32 GetNbRows() const;
    //! Gets MS Excel sheet identifier of the range.
    DWORD GetSheetId() const;
    //! Sets the first row of the range.
    void SetRowBegin(INT32 rowbegin);
    //! Sets passed the last row of the range.
    void SetRowEnd(INT32 rowend);
    //! Sets the first column of the range.
    void SetColBegin(INT32 colbegin);
    //! Sets passed the last column of the range.
    void SetColEnd(INT32 colend);
    //! Sets MS Excel sheet identifier of the range.
    void SetSheetId(DWORD);
    //@}

    //! \name Access operator
    //@{
    //! Access operator
    //XlfOper operator()(INT32 relativerow, INT32 relativecol) const;
    template <class T>
    T element(INT32 r, INT32 c) const {
#if !defined(NDEBUG)
        if (rowbegin_ + r > rowend_ || colbegin_ + c > colend_)
        {
            std::cerr << "XlfRef access out of range" << std::endl;
        }
#endif
        T res;
        res.Set(XlfRef(rowbegin_ + r, colbegin_ + c, sheetId_));
        return res;
    }
    //@}
private:
    //! Index of the top row of the range reference.
    INT32 rowbegin_;
    //! Index of one past the last row of the range reference.
    INT32 rowend_;
    //! Index of the left most column of the range reference.
    INT32 colbegin_;
    //! Index of one past the right most column of the range reference.
    INT32 colend_;
    //! Index of the sheet the reference is pointing to.
    DWORD sheetId_;
};

#ifdef NDEBUG
#include <xlw/XlfRef.inl>
#endif

#endif

