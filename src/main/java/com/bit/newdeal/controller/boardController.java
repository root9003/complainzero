package com.bit.newdeal.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.bit.newdeal.dto.Board;
import com.bit.newdeal.dto.Comment;
import com.bit.newdeal.dto.SearchCriteria;
import com.bit.newdeal.dto.Suggest;
import com.bit.newdeal.service.boardService;
import com.bit.newdeal.service.commentService;
import com.bit.newdeal.service.suggestService;

@Controller
public class boardController {
  @Autowired
  private boardService boardService;
  @Autowired
  private commentService commentService;
  @Autowired
  private suggestService suggestService;
  
  @RequestMapping("boardForm.do")
  public ModelAndView boardForm(@ModelAttribute SearchCriteria cri) {
	  
    ModelAndView mav = new ModelAndView();
    
    mav.addObject("boardList", boardService.selectAllBoard(cri));
    mav.addObject("pageMaker", boardService.countPageing(cri));
    
   mav.setViewName("board/boardForm");
   
    return mav;
  }
  
  @RequestMapping("writeBoardForm.do")
  public String writeBoardForm() {
    return "board/writeBoardForm";
  }
  
  @RequestMapping("writeBoard.do")
  public String writeBoard(Board board, 
      @RequestParam(value="uFile", required=false) MultipartFile uFile,
      Principal principal, HttpServletRequest request) {
    String path = request.getSession().getServletContext().getRealPath("/");
    boardService.insertBoard(board, uFile, path, principal);
    
    return "redirect:boardForm.do";
  }
  
  @RequestMapping("selectOneBoard.do")
  public ModelAndView selectOneBoard(int bno, Principal principal, 
                                     @RequestParam(required=false) String type) {
    ModelAndView mav = new ModelAndView();
    
    mav.addObject("boardDetail", boardService.selectOneBoard(bno));
    mav.addObject("commentList", commentService.selectComment(bno));
    mav.addObject("readCount", boardService.readCount(bno));
    mav.addObject("likeCount", boardService.likeCount(bno));
    mav.addObject("like", boardService.selectLike(principal.getName(), bno));
    mav.addObject("type", type);

    mav.setViewName("board/boardDetail");
    
    return mav;
  }

@RequestMapping("deleteBoard.do")
  public String deleteBoard(@RequestParam int bno) {
	  
	  boardService.deleteBoard(bno);
	  
	  return "redirect:boardForm.do";
  }
  
  
  @RequestMapping("updateBoardForm.do")
  public void updateBoardForm() {}
  
  @RequestMapping("updateBoard.do")
  public String updateBoard(Board board) {
    int bno = board.getBno();
    boardService.updateBoard(board);
    
    return "redirect:selectOneBoard.do?bno=" + bno;
  }
  
  @RequestMapping("boardDeleteForm.do")
  public String boardDelete (@RequestParam int bno) {
	  boardService.deleteBoard(bno);
	  System.out.println("asdfjkl");
	  return "redirect:boardForm.do";
  }
  
  //게시판 조회수
  

  @RequestMapping(value = "boardCommentSelect.do", method = RequestMethod.GET)
  public @ResponseBody List<HashMap> boardCommentSelect(int bno, Model model){
	  
	  /*model.addAttribute("comment", commentService.selectComment(bno));*/
	  
	  List<HashMap> comment = commentService.selectComment(bno);
	  
	  return comment;
  }
  
  //댓글 추가
  @RequestMapping(value = "boardCommentInsert.do", method = RequestMethod.POST)
  public @ResponseBody void boardCommentInsert(Comment comment, Principal principal) {
	  
	  comment.setId(principal.getName());
	  
    commentService.insertComment(comment);
  }
  
  //댓글 수정
  @RequestMapping(value = "boardCommentUpdate.do", method = RequestMethod.PUT, headers={"Content-type=application/json"})
  public @ResponseBody void boardCommentUpdate(@RequestBody Comment comment) {
	  
    commentService.updateComment(comment);
  }
  
  //댓글 삭제
  @RequestMapping(value = "boardCommentDelete.do/{cno}")
  public @ResponseBody void boardCommentDelete(@PathVariable(value="cno") int cno) {
	  
    commentService.deleteComment(cno);
  }
  
  @RequestMapping(value="writeSuggest.do", method = RequestMethod.POST)
  public @ResponseBody boolean writeSuggest(@ModelAttribute Suggest suggest, Principal principal) {
	  suggest.setId(principal.getName());
	  return suggestService.insertSuggest(suggest);
  }
  
  @RequestMapping("deleteSuggest.do")
  public String deleteSuggest(int sno) {
    /*suggestService.updateSuggest(sno);*/
    
    return "redirect:mySuggest.do";
  }
  
  //유저회원 내글조회
  @RequestMapping("myBoard.do")
  public ModelAndView myBoard(Principal principal) {
    ModelAndView mav = new ModelAndView();
    HashMap<String, Object> params = new HashMap<String, Object>();
    
    params.put("board", boardService.selectMyBoard(principal.getName()));
    params.put("comment", commentService.mySelectComment(principal.getName()));
    params.put("likes", boardService.likeBoard(principal.getName()));
    mav.addObject("myBoard", params);
    mav.setViewName("mypage/user/userMyPage_board");
    
    return mav;
  }
  
  //제공자유저 내 제안서 조회
  @RequestMapping("mySuggest.do")
  public ModelAndView mySuggest(Principal principal) {
    ModelAndView mav = new ModelAndView();
    mav.addObject("mySuggest", suggestService.selectMySuggest(principal.getName()));
    mav.setViewName("mypage/enter/enterUserMyPage_suggest");
    
    return mav;
  }
  
  @RequestMapping("download.do") // 추가
	public View download(@RequestParam(required=false) Integer bno) {
	  System.out.println("bno : " + bno);
		View view;
		HashMap<String, Object> params = new HashMap<>();
		if (bno != null) {
			params.put("bno", bno);
		}
		
		view = new DownloadView(boardService.getAttachFile(params));
		
		return view;
	}
}
