class Collision{
    float x,y,h,w, dx, dy;
    boolean isOnGround = false;
    boolean isJumping = false;
    Collision(float x, float y, float h,float w, float dx, float dy){
        this.x = x;
        this.y = y;
        this.h = h;
        this.w = w;
        this.dx = dx;
        this.dy = dy;
    }

    boolean collidesWith(Building b) {
    Vector2D[] contour = b.contour();
    Vector2D prevPoint = contour[contour.length - 1];

    for (int i = 0; i < contour.length; i++) {
      Vector2D curPoint = contour[i];

      // Check for intersection between the character's bounding box and the current edge
      if (lineRect((float)prevPoint.x, (float)prevPoint.y, (float)curPoint.x, (float)curPoint.y, x, y, w, h)) {
        return true;
      }

      prevPoint = curPoint;
    }

    return false;
  }

  // Helper function to check for intersection between a line segment and a rectangle
  boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) {
    // Check if either endpoint of the line segment is inside the rectangle
    if (pointRect(x1, y1, rx, ry, rw, rh) || pointRect(x2, y2, rx, ry, rw, rh)) {
      return true;
    }

    // Check if the line segment intersects any of the four edges of the rectangle
    if (lineLine(x1, y1, x2, y2, rx, ry, rx, ry + rh) ||
        lineLine(x1, y1, x2, y2, rx + rw, ry, rx + rw, ry + rh) ||
        lineLine(x1, y1, x2, y2, rx, ry, rx + rw, ry) ||
        lineLine(x1, y1, x2, y2, rx, ry + rh, rx + rw, ry + rh)) {
      return true;
    }

    return false;
  }

  // Helper function to check for intersection between two line segments
  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));
    float ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1));

    return (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1);
  }

// Helper function to check if a point is inside a rectangle
  boolean pointRect(float px, float py, float rx, float ry, float rw, float rh) {
    return (px >= rx && px <= rx + rw && py >= ry && py <= ry + rh);
  }

  void resolveCollision(Building b) {
    Vector2D[] contour = b.contour();
    Vector2D minX = contour[0];
    Vector2D minY = contour[0]; // Initialize minY to the first point
    Vector2D maxX = contour[0];
    Vector2D maxY = contour[0]; // Initialize maxY to the first point

    // Find the actual minimum and maximum Y values in the contour array
    for (int i = 0; i < contour.length; i++) {
      if (contour[i].y < minY.y) {
        minY = contour[i];
      }
      if (contour[i].y > maxY.y) {
        maxY = contour[i];
      }
      if (contour[i].x < minX.x) {
        minX = contour[i];
      }
      if (contour[i].x > maxX.x) {
        maxX = contour[i];
      }
    }

    if (y + h > minY.y && y < minY.y + h/2) {
      // Collision from top
      dy = 0;
      y = (float)minY.y - h;
      isOnGround = true;
      isJumping = false;
    } else if (y < maxY.y && y + h/2 > maxY.y) {
      // Collision from bottom
      dy = 0;
      y = (float)minY.y;
    } else if (x + w > minX.x && x < minX.x + w/2) {
      // Collision from left
      dx = 0;
      x = (float)minX.x - w;
    } else if (x < maxX.x && x + w/2 > maxX.x) {
      // Collision from right
      dx = 0;
      x = (float)maxX.x;
    }
  }

}